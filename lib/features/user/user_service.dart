import 'dart:io';
import 'dart:io' show Platform;

import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/screen/user/user_model.dart';

class UserAPIService
    extends Client<User, String, ResultInfo<User>, UserFilter> {
  static final UserAPIService instance = UserAPIService._instantiate();

  final String baseUrlIOS = 'http://localhost:8080';
  final String baseUrlAndroid = 'http://10.0.2.2:8080';

  UserAPIService._instantiate()
      : super(
          serviceUrl: Platform.isIOS
              ? 'http://localhost:8083/users'
              : 'http://10.0.2.2:8083/users',
          createObjectFromJson: User.fromJson,
          getId: User.getId,
        );
}
