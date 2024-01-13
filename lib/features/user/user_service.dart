import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/features/user/user_model.dart';
import 'package:flutter_admin/utils/http_helper.dart';

class UserAPIService
    extends Client<User, String, UserFilter> {
  static final UserAPIService instance = UserAPIService._instantiate();

  UserAPIService._instantiate()
      : super(
          serviceUrl: HttpHelper.instance.getUrl() + '/users',
          fromJson: User.fromJson,
          getId: User.getId,
        );
}
