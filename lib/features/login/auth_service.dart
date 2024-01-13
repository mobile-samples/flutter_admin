import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_admin/features/login/auth_model.dart';
import 'package:flutter_admin/utils/http_helper.dart';

class APIService {
  APIService._instantiate();
  static final APIService instance = APIService._instantiate();

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
      ).then((value) {
        dynamic authRes = jsonDecode(value.body)['user'];
        AuthInfo auth = AuthInfo.fromJson(authRes);
        HttpHelper.instance.setToken(auth.token);
        return auth;
      });
  }
}
