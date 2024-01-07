import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/features/user/user_model.dart';

class Role {
  String roleId;
  String roleName;
  String status;
  String remark;
  List<String>? privileges;
  List<User>? users;

  Role(
    this.roleId,
    this.roleName,
    this.status,
    this.remark,
    this.privileges,
  );

  Map<String, dynamic> toJson() {
    final map = {
      'roleName': roleName,
      'status': status,
      'remark': remark,
    };
    return map;
  }

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        json['roleId'] ?? json['roleid'],
        json['roleName'] ?? json['rolename'],
        json['status'],
        json['remark'],
        json['privileges'] == null
            ? []
            : List<String>.from(json['privileges']
                .map((e) => e.split(' ')[0].toString())
                .toList()),
      );

  static String getId(Role role) => role.roleId;
}

class Privilege {
  String id;
  String name;
  String icon;
  String path;
  // int permissions;
  // String resource;
  List<Privilege> children;

  Privilege(
    this.id,
    this.name,
    this.icon,
    this.path,
    // this.permissions,
    // this.resource,
    this.children,
  );

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        json['id'],
        json['name'],
        json['icon'] as String,
        json['path'] as String,
        // json['permissions'] as int,
        // json['resource'] as String,
        List<Privilege>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privilege.fromJson(x))),
      );
}

class Status {
  static String active = 'A';
  static String inactive = 'I';
}

class RoleFilter extends Filter {
  String? roleId;
  String? roleName;
  List<String>? status;
  String? remark;
  String? description;

  RoleFilter(
    this.roleId,
    this.roleName,
    this.status,
    this.remark,
    this.description,
    int? limit,
    int? page,
  ) : super(limit, page);

  @override
  Map<String, dynamic> toJson() => {};
}
