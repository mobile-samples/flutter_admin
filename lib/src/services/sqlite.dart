import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_admin/src/models/search.dart';
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

    var exists = await databaseExists(path);

    if (!exists) {
      print('Creating new copy from asset');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join('assets', 'sqlite.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Opening existing database');
    }

    var database = await openDatabase(path);

    return database;
  }

  Future<SearchResult<User>> searchUser(UserFilter filters) async {
    final Database db = await SqliteService.db();

    final String displayname = '%' + filters.displayName! + '%';
    final String username = '%' + filters.username! + '%';

    final String builtQueryStatus = () {
      if (filters.status != null && filters.status!.isNotEmpty) {
        final String status = filters.status!.map((e) => "'$e'").join(',');
        return ' and status in ($status)';
      }
      return '';
    }();

    final int? total = Sqflite.firstIntValue(
      await db.rawQuery(
        'select count(*) from users where username like ? and displayname like ? $builtQueryStatus',
        [displayname, username],
      ),
    );

    if (total != null && total != 0) {
      final List<Map<String, dynamic>> res = await db.rawQuery(
        'select * from users where username like ? and displayname like ? $builtQueryStatus limit ? offset ?',
        [
          displayname,
          username,
          filters.limit,
          ((filters.page! - 1) * filters.limit!)
        ],
      );
      return SearchResult<User>.fromJson({
        'list': res,
        'total': total,
      });
    } else {
      return SearchResult<User>.fromJson({
        'list': null,
        'total': total,
      });
    }
  }

  Future<User> loadUser(String userId) async {
    final Database db = await SqliteService.db();

    final List<Map<String, dynamic>> user =
        await db.rawQuery('select * from users where userid = ?', [userId]);
    final Map<String, dynamic> newUser = {...user[0]};

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

  Future<ResultInfo<User>> updateUser(User user) async {
    final Database db = await SqliteService.db();

    Map<String, dynamic> data = {
      // 'userid': user.userId,
      'displayname': user.displayName,
      'title': user.title,
      'position': user.position,
      'phone': user.phone,
      'email': user.email,
      'gender': user.gender,
      'status': user.status,
    };
    final int resStatus = await db
        .update('users', data, where: 'userid = ?', whereArgs: [user.userId]);
    if (resStatus == 1) {
      final User resVales = await loadUser(user.userId);
      return ResultInfo<User>(resStatus, resVales);
    } else {
      return ResultInfo<User>(resStatus, null);
    }
  }
}
