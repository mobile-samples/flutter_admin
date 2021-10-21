import 'package:flutter_admin/src/models/user.dart';

class Role {
  String roleId;
  String roleName;
  String status;
  String remark;
  List<String>? privileges;
  List<User>? users;
  // DateTime? createdAt;
  // String? createdBy;
  // DateTime? updatedAt;
  // String? updatedBy;

  Role(
    this.roleId,
    this.roleName,
    this.status,
    this.remark,
    this.privileges,
    // this.createdAt,
    // this.createdBy,
    // this.updatedAt,
    // this.updatedBy,
  );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        json['roleId'],
        json['roleName'],
        json['status'],
        json['remark'],
        json['privileges'] == null
            ? []
            : List<String>.from(json['privileges']
                .map((e) => e.split(' ')[0].toString())
                .toList()),
        // json['createdAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        // json['createdBy'] != null ? json['createdBy'] : '',
        // json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        // json['updatedBy'] != null ? json['updatedBy'] : '',
      );
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

class Status {
  static String active = 'A';
  static String inactive = 'I';
}
