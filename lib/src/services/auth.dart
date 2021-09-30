import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String baseUrlIOS = 'http://localhost:8080';
  final String baseUrlAndroid = 'http://10.0.2.2:8080';

  Future<AuthInfo> authenticate(
      {required String username, required String password}) async {
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    return http
        .post(
      Uri.parse(baseUrl + '/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'passcode': ''
      }),
    )
        .then((value) {
      dynamic authRes = jsonDecode(value.body)['user'];
      AuthInfo auth = AuthInfo.fromJson(authRes);
      return auth;
    });
  }

  Future<SearchResult> getRole(
      {required String token, required RoleFilter filters}) async {
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    final response = await http.post(
      Uri.parse(baseUrl + '/roles/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer' + token
      },
      body: jsonEncode(<String, dynamic>{
        'roleName': filters.roleName != null ? filters.roleName : '',
        'status': filters.status != null ? filters.status : [],
        'limit': filters.limit.isNaN ? 0 : filters.limit,
        'page': filters.page != null ? filters.page : 0,
      }),
    );
    if (response.statusCode == 200) {
      return SearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
