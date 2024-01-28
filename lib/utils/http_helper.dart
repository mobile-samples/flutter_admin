import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'auth_storage.dart';

class HttpHelper {
  HttpHelper._instantiate();
  static final HttpHelper instance = HttpHelper._instantiate();
  final String baseUrl = 'http://localhost:8083';
  final String baseAndroidUrl = 'http://10.0.2.2:8083';

  getUrl() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return baseAndroidUrl;
    } else {
      return baseUrl;
    }
  }

  jsonDecode(List<int> bodyBytes) {
    String source = const Utf8Decoder().convert(bodyBytes);
    return json.decode(source);
  }

  buildHeader() async {
    final token = await AuthStorage.getInfo('token') ?? '';
    if (token != '') {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
    }
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }
}
