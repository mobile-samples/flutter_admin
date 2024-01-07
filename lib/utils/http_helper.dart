import 'dart:io' show Platform;
import 'dart:convert';

class HttpHelper {
  HttpHelper._instantiate();
  static final HttpHelper instance = HttpHelper._instantiate();
  final storage = const FlutterSecureStorage();
  final String baseUrlIOS = 'http://localhost:8083';
  final String baseUrlAndroid = 'http://localhost:8083';

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else {
      return baseUrlIOS;
    }
  }

  setToken(String token) {
    storage.write(key: "token", value: token);
  }

  jsonDecode(List<int> bodyBytes) {
    String source = const Utf8Decoder().convert(bodyBytes);
    return json.decode(source);
  }

  buildHeader() async {
    final token = await storage.read(key: 'token') ?? '';
    if (token != '') {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8'
    }
  }
}