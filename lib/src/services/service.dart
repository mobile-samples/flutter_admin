import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';

abstract class Service<T, M> {
  // User
  Future<User> loadUser(String userId);
  Future<SearchResult<User>> searchUser(UserFilter filters);
  Future<ResultInfo<User>> updateUser(User user);

  // Role
  Future<List<Privilege>> getPrivileges();
  Future<Role> loadRole(String roleId);
  Future<SearchResult<Role>> searchRole(RoleFilter filters);
  Future<ResultInfo<Role>> updateRole(Role role);
}
