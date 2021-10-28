import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';

abstract class Service<T, ID> {
  Future<T> load(ID id);
  Future<ResultInfo<T>> update(T obj);
}

abstract class SearchService<T, F> {
  Future<SearchResult<T>> search(F filters, int limit, int offset);
}




// abstract class Service<T, M> {
//   // User
//   Future<SearchResult<User>> searchUser(UserFilter filters);
//   Future<User> loadUser(String userId);
//   Future<ResultInfo<User>> updateUser(User user);

//   // Role
//   Future<SearchResult<Role>> searchRole(RoleFilter filters);
//   Future<List<Privilege>> getPrivileges();
//   Future<Role> loadRole(String roleId);
//   Future<ResultInfo<Role>> updateRole(Role role);
// }
