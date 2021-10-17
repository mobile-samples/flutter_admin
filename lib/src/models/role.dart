import 'package:flutter_admin/src/models/user.dart';

class RoleSM {
  String roleId;
  String roleName;
  String status;
  String remark;

  RoleSM(
    this.roleId,
    this.roleName,
    this.status,
    this.remark,
  );

  factory RoleSM.fromJson(Map<String, dynamic> json) => RoleSM(
        json['roleId'],
        json['roleName'],
        json['status'],
        json['remark'],
      );
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
        case RoleSM:
          return List<T>.from(json['list'].map((x) => RoleSM.fromJson(x)));
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

class RoleFilter {
  String roleName;
  List<String> status;
  int page;
  int limit;

  RoleFilter(
    this.roleName,
    this.status,
    this.limit,
    this.page,
  );
}

class Role {
  String roleId;
  String roleName;
  String status;
  String remark;
  List<String> privileges;
  List<User>? users;

  Role(
    this.roleId,
    this.roleName,
    this.status,
    this.remark,
    this.privileges,
  );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
      json['roleId'],
      json['roleName'],
      json['status'],
      json['remark'],
      json['privileges'] == null
          ? []
          : List<String>.from(json['privileges'])
              .map((e) => e.split(' ')[0].toString())
              .toList());
}

class Privilege {
  String id;
  String name;
  List<Privilege> children;

  Privilege(
    this.id,
    this.name,
    this.children,
  );

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        json['id'],
        json['name'],
        List<Privilege>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privilege.fromJson(x))),
      );
}

abstract class Tracking {
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  Tracking(this.createdAt, this.createdBy, this.updatedAt, this.updatedBy);
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

class Status {
  static String active = 'A';
  static String inactive = 'I';
}
