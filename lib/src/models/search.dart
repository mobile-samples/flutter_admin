import 'package:flutter_admin/src/common/client/model.dart';

class UserFilter extends Filter {
  UserFilter(
    this.userId,
    this.username,
    this.email,
    this.displayName,
    this.status,
    int? limit,
    int? page,
  ) : super(limit, page);

  String? userId;
  String? username;
  String? email;
  String? displayName;
  List<String>? status;

  @override
  Map<String, dynamic> toJson() => {
        'username': username ?? '',
        'displayName': displayName ?? '',
        'status': status ?? [],
        'limit': limit ?? 0,
        'page': page ?? 0,
      };
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
