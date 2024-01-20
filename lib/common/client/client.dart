import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

abstract class ViewClient<T, ID> {
  String serviceUrl;
  T Function(Map<String, dynamic> json) fromJson;

  ViewClient({required this.serviceUrl, required this.fromJson});

  Future<List<T>> all() {
    final uri = Uri.parse(this.serviceUrl);
    return http.get(uri)
      .then((res) {
        if (res.statusCode == 200) {
          var jsonList = jsonDecode(res.body) as List;
          return jsonList.map<T>((json) => fromJson(json)).toList();
        } else {
          throw Exception('Failed to load all');
        }
      })
      .catchError((err) {
        throw Exception('Fail to get all');
      });
  }

  Future<T> load(ID id) async {
    final uri = Uri.parse('$serviceUrl/$id');
    return http.get(uri)
      .then((res) {
        if (res.statusCode == 200) {
          return fromJson(jsonDecode(res.body));
        } else {
          throw Exception('Failed to load by id');
        }
      })
      .catchError((err) {
        throw err;
      });
  }
}

class GenericClient<T, ID, R> extends ViewClient<T, ID> {
  R Function(String) createResult;
  String Function(T) getId;

  GenericClient({
    required super.serviceUrl,
    required super.fromJson,
    required this.createResult,
    required this.getId,
  });

  Future<R> insert(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.post(uri, body: jsonEncode(object))
      .then((res) {
        if (res.statusCode == 404 || res.statusCode == 410) {
          throw Exception('Not found');
        }
        if (res.statusCode == 409) {
          throw Exception('Version Error');
        }
        return this.createResult(res.body);
      })
      .catchError((err) {
        throw err;
      });
  }

  Future<R> update(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.put(uri, body: jsonEncode(object))
      .then((res) {
        if (res.statusCode == 404 || res.statusCode == 410) {
          throw Exception('Not found');
        }
        if (res.statusCode == 409) {
          throw Exception('Version Error');
        }
        return this.createResult(res.body);
      })
      .catchError((err) {
        throw err;
      });
  }

  Future<R> patch(T object) async {
    final uri = Uri.parse('$serviceUrl/${this.getId(object)}');
    return http.patch(uri, body: jsonEncode(object))
      .then((res) {
        if (res.statusCode == 404 || res.statusCode == 410) {
          throw Exception('Not found');
        }
        if (res.statusCode == 409) {
          throw Exception('Version Error');
        }
        return this.createResult(res.body);
      })
      .catchError((err) {
        throw err;
      });
  }

  Future<num> delete(ID id) async {
    final uri = Uri.parse('$serviceUrl/$id');
    return http.delete(uri)
      .then((res) {
        if (res.statusCode == 404 || res.statusCode == 410) {
          throw Exception('Not found');
        }
        if (res.statusCode == 409) {
          throw Exception('Version Error');
        }
        return res.body as int;
      })
      .catchError((err) {
        throw err;
      });
  }
}

class WebClient<T, ID> extends GenericClient<T, ID, ResultInfo<T>> {
  WebClient({
    required super.serviceUrl,
    required super.fromJson,
    required super.getId,
  }) : super(
          createResult: (value) {
            if (int.tryParse(value) != null) {
              return ResultInfo(status: value as int);
            } else {
              return ResultInfo(value: fromJson(jsonDecode(value)));
            }
          },
        );
}

class SearchClient<T, S extends Filter> {
  String serviceUrl;
  T Function(Map<String, dynamic> json) fromJson;

  SearchClient({required this.serviceUrl, required this.fromJson});

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
          .map((e) => this.fromJson(e as Map<String, dynamic>))
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

class GenericSearchClient<T, ID, R, S extends Filter>
    extends SearchClient<T, S> {
  late GenericClient<T, ID, R> genericClient;
  GenericSearchClient({
    required String serviceUrl,
    required T Function(Map<String, dynamic>) fromJson,
    required R Function(String) createResult,
    required String Function(T) getId,
  }) : super(serviceUrl: serviceUrl, fromJson: fromJson) {
    this.genericClient = GenericClient(
      serviceUrl: serviceUrl,
      fromJson: fromJson,
      createResult: createResult,
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

class Client<T, ID, F extends Filter> extends GenericSearchClient<T, ID, ResultInfo<T>, F> {
  Client({
    required super.serviceUrl, 
    required super.fromJson, 
    required super.getId,
  }) : super (
          createResult: (value) {
            if (int.tryParse(value) != null) {
              return ResultInfo(status: value as int);
            } else {
              return ResultInfo(value: fromJson(jsonDecode(value)));
            }
          },
  );
}
