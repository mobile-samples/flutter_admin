class RoleSM {
  String roleId;
  String roleName;
  String status;
  String remark;

  RoleSM({
    required this.roleId,
    required this.roleName,
    required this.status,
    required this.remark,
  });

  factory RoleSM.fromJson(Map<String, dynamic> json) => RoleSM(
        roleId: json['roleId'],
        roleName: json['roleName'],
        status: json['status'],
        remark: json['remark'],
      );
}

class SearchResult {
  List<RoleSM> list;
  int total;
  bool? last;
  String? nextPageToken;

  SearchResult({
    required this.list,
    required this.total,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        list: json['list'] != null
            ? List<RoleSM>.from(json['list'].map((x) => RoleSM.fromJson(x)))
            : [],
        total: json['total'],
      );
}

class RoleFilter {
  String roleName;
  List<String> status;
  int page;
  int limit;

  RoleFilter({
    required this.roleName,
    required this.status,
    required this.limit,
    required this.page,
  });
}

class Role {
  String roleId;
  String roleName;
  String status;
  String remark;
  List<String> privileges;

  Role({
    required this.roleId,
    required this.roleName,
    required this.status,
    required this.remark,
    required this.privileges,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json['roleId'],
        roleName: json['roleName'],
        status: json['status'],
        remark: json['remark'],
        privileges: json['privileges'] != null
            ? List<String>.from(json['privileges'])
            : [],
      );
}

class Privilege {
  Privilege({
    required this.id,
    required this.name,
    required this.children,
  });
  String id;
  String name;
  List<Privilege> children;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        children: List<Privilege>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privilege.fromJson(x))),
        id: json['id'],
        name: json['name'],
      );
}
