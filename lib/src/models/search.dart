import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/user.dart';

class UserFilter {
  UserFilter(
    this.username,
    this.displayName,
    this.status,
    this.limit,
    this.page,
  );
  String username;
  String displayName;
  List<String> status;
  int limit;
  int page;
}

abstract class Filter {
  int? page;
  int? limit;
  int? firstLimit;
  List<String>? fields; //string[];
  String? sort;
  String? currentUserId;

  String? q;
  String? keyword;
  List<String>? excluding; //string[]|number[];
  String? refId; //string|number;

  int? pageIndex;
  int? pageSize;

  Filter(this.limit, this.page);
}

class SearchResult<T> {
  List<T> list;
  int total;
  bool? last;
  String? nextPageToken;

  SearchResult(
    this.list,
    this.total,
  );

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final _build = () {
      switch (T) {
        case Role:
          return List<T>.from(json['list'].map((x) => Role.fromJson(x)));
        default:
          return null;
      }
    };
    return SearchResult(
      json['list'] != null ? _build() ?? [] : [],
      json['total'],
    );
  }
}

class ErrorMessage {
  String field;
  String code;
  String? param; //string|number|Date;
  String? message;

  ErrorMessage(this.field, this.code, this.param, this.message);
}

class ResultInfo<T> {
  int status; //number|string
  List<ErrorMessage>? errors;
  T? value;
  String? message;

  ResultInfo(
    this.status,
    this.value,
  );

  factory ResultInfo.fromJson(Map<String, dynamic> json) {
    final _build = () {
      switch (T) {
        case User:
          return User.fromJson(json['value']) as T;
        case Role:
          return Role.fromJson(json['value']) as T;
        default:
          return null;
      }
    };
    return ResultInfo(
      json['status'],
      _build(),
    );
  }
}

class RoleFilter extends Filter {
  String? roleName;
  List<String>? status;

  RoleFilter(
    this.roleName,
    this.status,
    int? limit,
    int? page,
  ) : super(limit, page);
}
