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

  static Future<ListUsersSQL> getUsers(UserFilter filters) async {
    final Database db = await SqliteService.db();
    final String displayname = '%' + filters.displayName + '%';
    final String username = '%' + filters.username + '%';
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM users WHERE username LIKE ? AND displayname LIKE ? LIMIT ? OFFSET ?',
        [
          displayname,
          username,
          filters.limit,
          ((filters.page - 1) * filters.limit)
        ]);
    final list = queryResult.map((e) => UserSQL.fromJson(e)).toList();
    final total = list.length;
    return ListUsersSQL(list, total);
  }
}
