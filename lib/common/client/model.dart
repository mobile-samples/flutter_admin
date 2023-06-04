abstract class Filter {
  int? page;
  int? limit;
  int? firstLimit;
  List<String>? fields;
  String? sort;
  String? currentUserId;

  String? q;
  String? keyword;
  List<String>? excluding;
  String? refId;

  int? pageIndex;
  int? pageSize;

  Filter(this.limit, this.page);

  Map<String, dynamic> toJson();
}

class ErrorMessage {
  String field;
  String code;
  dynamic param;
  String? message;

  ErrorMessage(this.field, this.code, this.param, this.message);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      json['field'] as String,
      json['code'] as String,
      json['param'],
      json['message'] as String?,
    );
  }
}

class ResultInfo<T> {
  num status;
  List<ErrorMessage>? errors;
  T? value;
  String? message;

  ResultInfo(this.status, this.errors, this.value, this.message);
}

class SearchResult<T> {
  int total;
  List<T> list;
  String? nextPageToken;
  bool? last;

  SearchResult(this.total, this.list, this.nextPageToken, this.last);
}
