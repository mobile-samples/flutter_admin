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
