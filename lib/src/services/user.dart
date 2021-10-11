import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/utils/global-data.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class UserAPIService {
  UserAPIService._instantiate();

  static final UserAPIService instance = UserAPIService._instantiate();

  final String baseUrlIOS = 'http://localhost:8080';
  final String baseUrlAndroid = 'http://10.0.2.2:8080';

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    }
  }

  Future<ListUsers> getUsers(UserFilter filters) async {
    late String baseUrl = getUrl();
    return http
        .post(
      Uri.parse(baseUrl + '/users/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + GlobalData.token,
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
