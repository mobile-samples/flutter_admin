import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/utils/global_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String baseUrlIOS = 'http://localhost:8083';
  final String baseUrlAndroid = 'http://10.0.2.2:8083';

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    }
  }

  Future<AuthInfo> authenticate(
      {required String username, required String password}) async {
    late String baseUrl = getUrl();
    return http
        .post(
      Uri.parse(baseUrl + '/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    )
        .then((value) {
      dynamic authRes = jsonDecode(value.body)['user'];
      AuthInfo auth = AuthInfo.fromJson(authRes);
      GlobalData.token = auth.token;
      return auth;
    });
  }
}
