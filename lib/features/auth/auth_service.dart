import 'dart:convert';
import 'package:flutter_admin/utils/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_admin/features/auth/auth_model.dart';
import 'package:flutter_admin/utils/http_helper.dart';

class AuthService {
  AuthService._instantiate();
  static final AuthService instance = AuthService._instantiate();

  Future<AuthInfo> authenticate(
      {required String username, required String password}) async {
    late String baseUrl = HttpHelper.instance.getUrl();
    final header = await HttpHelper.instance.buildHeader();
    return http
        .post(
      Uri.parse('$baseUrl/authenticate'),
      headers: header,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    )
        .then((value) async {
      dynamic user = jsonDecode(value.body)['user'];
      AuthInfo authInfo = AuthInfo.fromJson(user);
      await AuthStorage.setInfo('token', authInfo.token);
      await AuthStorage.setInfo('expired', authInfo.tokenExpiredTime);
      String userInfo = jsonEncode(user);
      await AuthStorage.setInfo('user', userInfo);
      return authInfo;
    });
  }

  Future<AuthInfo> tryAutoLogin() async {
    final token = await AuthStorage.getInfo('token');
    final expired = await AuthStorage.getInfo('expired');
    if (token != null && expired != null) {
      if (DateTime.parse(expired.toString())
          .toUtc()
          .isAfter(DateTime.now().toUtc())) {
        return AuthStorage.getInfo('user')
            .then((value) => AuthInfo.fromJson(jsonDecode(value)));
      }
    }
    return Future.error('Token is expired!');
  }
}
