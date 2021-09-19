import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class UserAPIService {
  UserAPIService._instantiate();

  static final UserAPIService instance = UserAPIService._instantiate();

  final String baseUrlIOS = 'http://localhost:7070';
  final String baseUrlAndroid = 'http://10.0.2.2:7070';

  Future<ListUsers> getUsers(
      {required String token, required UserFilter filters}) async {
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    return http
        .post(
      Uri.parse(baseUrl + '/users/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer' + token
      },
      body: jsonEncode(<String, dynamic>{
        'username': filters.username != '' ? filters.username : '',
        'displayName': filters.displayName != '' ? filters.displayName : '',
        'status': filters.status.length == 0 ? [] : filters.status,
        'limit': filters.limit.isNaN ? 0 : filters.limit,
        'page': filters.page
      }),
    )
        .then((value) {
      dynamic usersRes = jsonDecode(value.body);
      ListUsers users = ListUsers.fromJson(usersRes);
      return users;
    });
  }
}
