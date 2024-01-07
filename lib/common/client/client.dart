import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

abstract class ViewClient<T, ID> {
  String serviceUrl;
  T Function(Map<String, dynamic> json) fromJson;

  ViewClient({required this.serviceUrl, required this.fromJson});

  List<T> all(String jsonString) {
    final uri = Uri.parse(this.serviceUrl);
    return http.get(uri).then((res) {

    }).catchError((err) {
      throw Exception('Fail to get all')
    })
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map<T>((json) => fromJson(json)).toList();
  }

  T parseGetResult(String jsonString) {
    final json = jsonDecode(jsonString);
    return createObjectFromJson(json);
  }

  Future<List<T>> all() {
    final uri = Uri.parse(this.serviceUrl);
    return http.get(uri).then((res) {
      if (res.statusCode == 200) {
        return compute(parseGetAllResult, res.body);
      } else {
        throw Exception('Failed to load all');
      }
    }).catchError((err) {
      throw err;
    });
  }

  Future<T> load(ID id) async {
    final uri = Uri.parse('$serviceUrl/$id');
    return http.get(uri).then((res) {
      if (res.statusCode == 200) {
        return compute(parseGetResult, res.body);
      } else {
        throw Exception('Failed to load by id');
      }
    }).catchError((err) {
      throw err;
    });
  }
}

class GenericClient<T, ID, R> extends ViewClient<T, ID> {
  Function(Map<String, dynamic> json) createResultInfoFromJson;
  String Function(T) getId;

  GenericClient({
    required String serviceUrl,
    required T Function(Map<String, dynamic>) createObjectFromJson,
    required this.createResultInfoFromJson,
    required this.getId,
  }) : super(
            serviceUrl: serviceUrl, createObjectFromJson: createObjectFromJson);

  R formatResultInfo(String jsonString) {
    final json = jsonDecode(jsonString);
    return this.createResultInfoFromJson(json);
  }

  Future<R> insert(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.post(uri, body: jsonEncode(object)).then((value) {
      if (value.statusCode == 404 || value.statusCode == 410) {
        throw Exception('Not found');
      }
      if (value.statusCode == 409) {
        throw Exception('Version Error');
      }
      return compute(formatResultInfo, value.body);
    }).catchError((err) {
      throw err;
    });
  }

  Future<R> update(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.put(uri, body: jsonEncode(object)).then((value) {
      if (value.statusCode == 404 || value.statusCode == 410) {
        throw Exception('Not found');
      }
      if (value.statusCode == 409) {
        throw Exception('Version Error');
      }
      return compute(formatResultInfo, value.body);
    }).catchError((err) {
      throw err;
    });
  }

  Future<R> patch(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.patch(uri, body: jsonEncode(object)).then((value) {
      if (value.statusCode == 404 || value.statusCode == 410) {
        throw Exception('Not found');
      }
      if (value.statusCode == 409) {
        throw Exception('Version Error');
      }
      return compute(formatResultInfo, value.body);
    }).catchError((err) {
      throw err;
    });
  }

  Future<num> delete(ID id) async {
    final uri = Uri.parse('$serviceUrl/$id');
    return http.delete(uri).then((value) {
      if (value.statusCode == 404 || value.statusCode == 410) {
        throw Exception('Not found');
      }
      if (value.statusCode == 409) {
        throw Exception('Version Error');
      }
      return value.body as int;
    }).catchError((err) {
      throw err;
    });
  }
}

class WebClient<T, ID> extends GenericClient<T, ID, ResultInfo<T>> {
  WebClient({
    required String serviceUrl,
    required T Function(Map<String, dynamic>) createObjectFromJson,
    required String Function(T) getId,
  }) : super(
          serviceUrl: serviceUrl,
          createObjectFromJson: createObjectFromJson,
          createResultInfoFromJson: (json) => ResultInfo(
              json['status'],
              (json['errors'] as List<dynamic>?)
                  ?.map((e) => ErrorMessage.fromJson(e as Map<String, dynamic>))
                  .toList(),
              createObjectFromJson(json['value']),
              json['message']),
          getId: getId,
        );
}

class SearchClient<T, S extends Filter> {
  String serviceUrl;
  T Function(Map<String, dynamic> json) createObjectFromJson;

  SearchClient({required this.serviceUrl, required this.createObjectFromJson});

  String makeUrlParameters(Map<String, dynamic> filter) {
    List<String> params = [];
    filter.forEach((key, value) {
      params.add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(value)}');
    });
    return params.join(',');
  }

  SearchResult<T> buildSearchResult(String res) {
    final json = jsonDecode(res);
    return SearchResult(
      json['total'] as int,
      (json['list'] as List<dynamic>)
          .map((e) => this.createObjectFromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
      json['last'] as bool?,
    );
  }

  Future<SearchResult<T>> search(
      bool isPostRequest, bool isSearchGet, S filter) {
    if (isPostRequest) {
      String postSearchUrl = '${this.serviceUrl}/search';
      return http
          .post(Uri.parse(postSearchUrl), body: jsonEncode(filter))
          .then((res) {
        if (res.statusCode == 200) {
          return buildSearchResult(res.body);
        } else {
          return SearchResult<T>(0, [], '', true);
        }
      }).catchError((err) {
        throw err;
      });
    } else {
      String searchUrl =
          '${isSearchGet ? '${this.serviceUrl}/search' : this.serviceUrl}?${makeUrlParameters(filter.toJson())}';
      return http.get(Uri.parse(searchUrl)).then((res) {
        if (res.statusCode == 200) {
          return buildSearchResult(res.body);
        } else {
          return SearchResult<T>(0, [], '', true);
        }
      }).catchError((err) {
        throw err;
      });
    }
  }
}

class Client<T, ID, R extends ResultInfo<T>, S extends Filter>
    extends SearchClient<T, S> {
  late GenericClient<T, ID, R> genericClient;
  Client({
    required String serviceUrl,
    required T Function(Map<String, dynamic>) createObjectFromJson,
    required String Function(T) getId,
  }) : super(
            serviceUrl: serviceUrl,
            createObjectFromJson: createObjectFromJson) {
    this.genericClient = GenericClient(
      serviceUrl: serviceUrl,
      createObjectFromJson: createObjectFromJson,
      createResultInfoFromJson: (json) => ResultInfo(
          json['status'] as num,
          (json['errors'] as List<dynamic>?)
              ?.map((e) => ErrorMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
          createObjectFromJson(json['value']),
          json['message']),
      getId: getId,
    );
  }

  Future<List<T>> all() {
    return this.genericClient.all();
  }

  Future<T> load(ID id) {
    return this.genericClient.load(id);
  }

  Future<R> insert(T obj) {
    return this.genericClient.insert(obj);
  }

  Future<R> update(T obj) {
    return this.genericClient.update(obj);
  }

  Future<R> patch(T obj) {
    return this.genericClient.patch(obj);
  }

  Future<num> delete(ID id) {
    return this.genericClient.delete(id);
  }
}
