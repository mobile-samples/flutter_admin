import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();

  static Future setInfo(String key, value) async {
    await _storage.write(key: key, value: value);
  }

  static Future getInfo(String key) async {
    return await _storage.read(key: key);
  }
}
