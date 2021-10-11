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

class SearchResult {
  List<RoleSM> list;
  int total;
  bool? last;
  String? nextPageToken;

  SearchResult(
    this.list,
    this.total,
  );

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        json['list'] != null
            ? List<RoleSM>.from(json['list'].map((x) => RoleSM.fromJson(x)))
            : [],
        json['total'],
      );
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
  Privilege(
    this.id,
    this.name,
    this.children,
  );
  String id;
  String name;
  List<Privilege> children;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        json['id'],
        json['name'],
        List<Privilege>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privilege.fromJson(x))),
      );
}
