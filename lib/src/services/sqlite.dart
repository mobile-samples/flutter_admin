import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  // static get displayname => null;

  SqliteService._instantiate();
  static final SqliteService instance = SqliteService._instantiate();

  static Future<Database> db() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'database.db');
    // await deleteDatabase(path);

    var exists = await databaseExists(path);

    if (!exists) {
      print('Creating new copy from asset');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join('assets', 'sqlite3.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Opening existing database');
    }

    var database = await openDatabase(path);

    return database;
  }

  // Future<SearchResult<User>> searchUser(UserFilter filters) async {
  //   final Database db = await SqliteService.db();

  //   final String displayname = '%' + filters.displayName! + '%';
  //   final String username = '%' + filters.username! + '%';

  //   final String builtQueryStatus = () {
  //     if (filters.status != null && filters.status!.isNotEmpty) {
  //       final String status = filters.status!.map((e) => "'$e'").join(',');
  //       return ' and status in ($status)';
  //     }
  //     return '';
  //   }();

  //   final int? total = Sqflite.firstIntValue(
  //     await db.rawQuery(
  //       'select count(*) from users where username like ? and displayname like ? $builtQueryStatus',
  //       [displayname, username],
  //     ),
  //   );

  //   if (total != null && total != 0) {
  //     final List<Map<String, dynamic>> res = await db.rawQuery(
  //       'select * from users where username like ? and displayname like ? $builtQueryStatus limit ? offset ?',
  //       [
  //         displayname,
  //         username,
  //         filters.limit,
  //         ((filters.page! - 1) * filters.limit!)
  //       ],
  //     );
  //     return SearchResult<User>.fromJson({
  //       'list': res,
  //       'total': total,
  //     });
  //   } else {
  //     return SearchResult<User>.fromJson({
  //       'list': null,
  //       'total': total,
  //     });
  //   }
  // }

  Future<User> loadUser(String userId) async {
    final Database db = await SqliteService.db();

    final List<Map<String, dynamic>> user =
        await db.rawQuery('select * from users where userid = ?', [userId]);
    final Map<String, dynamic> newUser = {...user.first};

    final List<Map<String, dynamic>> userRoles = await db
        .rawQuery('select roleid from userroles where userid = ?', [userId]);

    if (userRoles.isNotEmpty) {
      final List<String> roles = [];
      userRoles.forEach((e) {
        roles.add(e['roleid']);
      });
      newUser['roles'] = roles;
    }
    return User.fromJson(newUser);
  }

  // Future<ResultInfo<User>> updateUser(User user) async {
  //   final Database db = await SqliteService.db();
  //   final userMap = user.toMap();
  //   final int resStatus = await db.update('users', userMap,
  //       where: 'userid = ?', whereArgs: [user.userId]);
  //   if (resStatus == 1) {
  //     final User resValue = await loadUser(user.userId);
  //     return ResultInfo<User>(resStatus, resValue);
  //   } else {
  //     return ResultInfo<User>(resStatus, null);
  //   }
  // }

  // Future<SearchResult<Role>> searchRole(RoleFilter filters) async {
  //   final Database db = await SqliteService.db();
  //   final String roleName =
  //       filters.roleName != null ? '%' + filters.roleName! + '%' : '%%';

  //   final String builtQueryStatus = () {
  //     if (filters.status != null && filters.status!.isNotEmpty) {
  //       final String status = filters.status!.map((e) => "'$e'").join(',');
  //       return ' and status in ($status)';
  //     }
  //     return '';
  //   }();

  //   final int? total = Sqflite.firstIntValue(
  //     await db.rawQuery(
  //       'select count(*) from roles where rolename like ? $builtQueryStatus',
  //       [roleName],
  //     ),
  //   );

  //   if (total != null && total != 0) {
  //     final List<Map<String, dynamic>> res = await db.rawQuery(
  //       'select * from roles where rolename like ? $builtQueryStatus limit ? offset ?',
  //       [roleName, filters.limit, ((filters.page! - 1) * filters.limit!)],
  //     );
  //     return SearchResult<Role>.fromJson({
  //       'list': res,
  //       'total': total,
  //     });
  //   } else {
  //     return SearchResult<Role>.fromJson({
  //       'list': null,
  //       'total': total,
  //     });
  //   }
  // }

  Future<List<Privilege>> getPrivileges() async {
    final Database db = await SqliteService.db();

    final List<Map<String, dynamic>> res =
        await db.rawQuery('select * from modules');

    final List<Map<String, dynamic>> newRes = [];
    // get parent
    res.forEach((e) {
      if (e['parent'] == '') {
        newRes.add({...e, 'id': e['moduleid'], 'name': e['modulename']});
      }
    });

    // get children
    newRes.forEach((parent) {
      List<Map<String, dynamic>> childList = [];
      res.forEach((child) {
        if (parent['id'] == child['parent']) {
          childList.add(
              {...child, 'id': child['moduleid'], 'name': child['modulename']});
        }
      });
      parent['children'] = childList;
    });
    List<Privilege> priviList = [];
    newRes.forEach((e) {
      priviList.add(Privilege.fromJson(e));
    });
    return priviList;
  }

  Future<Role> loadRole(String roleId) async {
    final Database db = await SqliteService.db();

    final List<Map<String, dynamic>> role =
        await db.rawQuery('select * from roles where roleid = ?', [roleId]);
    final Map<String, dynamic> newRole = {...role.first};

    final List<Map<String, dynamic>> roleModules = await db.rawQuery(
        'select moduleid from rolemodules where roleid = ?', [roleId]);

    if (roleModules.length > 0) {
      final List<String> priviList = [];
      roleModules.forEach((e) {
        priviList.add(e['moduleid']);
      });
      newRole['privileges'] = priviList;
    }
    return Role.fromJson(newRole);
  }

  // Future<ResultInfo<Role>> updateRole(Role role) async {
  //   final Database db = await SqliteService.db();
  //   final Map<String, dynamic> roleMap = role.toMap();

  //   final int resStatus = await db.update('roles', roleMap,
  //       where: 'roleid = ?', whereArgs: [role.roleId]);

  //   final List<Map<String, dynamic>> roleModules = await db.rawQuery(
  //       'select moduleid from rolemodules where roleid = ?', [role.roleId]);

  //   final List<String> moduleIdsByDb =
  //       roleModules.map((e) => e['moduleid'] as String).toList();

  //   final List<String> deleteListByDB =
  //       moduleIdsByDb.where((e) => !role.privileges!.contains(e)).toList();

  //   final List<String> filterPrivileges =
  //       role.privileges!.where((e) => !moduleIdsByDb.contains(e)).toList();

  //   deleteListByDB.forEach((e) async {
  //     await db.rawDelete(
  //         'DELETE FROM rolemodules WHERE roleid = ? AND moduleid = ?',
  //         [role.roleId, e]);
  //   });

  //   filterPrivileges.forEach((e) async {
  //     final Map<String, dynamic> map = {
  //       'roleid': role.roleId,
  //       'moduleid': e,
  //       'permissions': 0,
  //     };
  //     await db.insert('rolemodules', map);
  //   });

  //   if (resStatus == 1) {
  //     final Role resValue = await loadRole(role.roleId);
  //     return ResultInfo<Role>(resStatus, resValue);
  //   } else {
  //     return ResultInfo<Role>(resStatus, null);
  //   }
  // }
}
