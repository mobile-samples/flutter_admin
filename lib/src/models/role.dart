class Role {
  String roleId;
  String roleName;
  String status;
  String remark;
  String? createdBy;
  DateTime? createdAt;
  String? updatedBy;
  DateTime? updatedAt;

  Role({
    required this.roleId,
    required this.roleName,
    required this.status,
    required this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json['roleId'],
        roleName: json['roleName'],
        status: json['status'],
        remark: json['remark'],
      );
}
