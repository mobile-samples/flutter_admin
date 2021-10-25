import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static get displayname => null;

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

    var database = await openDatabase(path, readOnly: true);

    return database;
  }

  static Future<SearchResult<User>> searchUser(UserFilter filters) async {
    final Database db = await SqliteService.db();
    final String displayname = '%' + filters.displayName! + '%';
    final String username = '%' + filters.username! + '%';
    final String status = filters.status!.map((e) => "'$e'").join(',');

    final String builtQueryStatus = () {
      if (filters.status != null && filters.status!.isNotEmpty) {
        print(filters.status!.map((e) => "'$e'"));
        return ' and status in ($status)';
      }
      return '';
    }();

    final List<Map<String, dynamic>> countTotal = await db.rawQuery(
        'select count(*) from users where username like ? and displayname like ? $builtQueryStatus',
        [displayname, username]);

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
      'total': countTotal[0]['count(*)'],
    });
  }

  static Future<User> loadUser(String userId) async {
    final Database db = await SqliteService.db();

    final List<Map<String, dynamic>> userRoles = await db
        .rawQuery('select roleid from userroles where userid = ?', [userId]);
    final List<Map<String, dynamic>> user =
        await db.rawQuery('select * from users where userid = ?', [userId]);

    final Map<String, dynamic> newUser = {...user[0]};
    List<String> roles = [];
    if (userRoles.isNotEmpty) {
      userRoles.forEach((e) {
        roles.add(e['roleid']);
      });
      newUser['roles'] = roles;
    }

    return User.fromJson(newUser);
  }
}
