import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;

import 'package:flutter_admin/src/common/client/client.dart';
import 'package:flutter_admin/src/common/client/model.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/utils/global_data.dart';
import 'package:http/http.dart' as http;

class UserAPIService
    extends Client<User, String, ResultInfo<User>, UserFilter> {
  static final UserAPIService instance = UserAPIService._instantiate();

  final String baseUrlIOS = 'http://localhost:8080';
  final String baseUrlAndroid = 'http://10.0.2.2:8080';

  UserAPIService._instantiate()
      : super(
          serviceUrl: 'http://localhost:8083/users',
          createObjectFromJson: User.fromJson,
          getId: User.getId,
        );

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    }
  }

  // Future<SearchResult<User>> search(UserFilter filters) async {
  //   late String baseUrl = getUrl();
  //   final response = await http.post(
  //     Uri.parse(baseUrl + '/users/search'),
  //     headers: GlobalData.buildHeader(),
  //     body: jsonEncode(<String, dynamic>{
  //       'username': filters.username ?? '',
  //       'displayName': filters.displayName ?? '',
  //       'status': filters.status ?? [],
  //       'limit': filters.limit ?? 0,
  //       'page': filters.page ?? 0,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     return SearchResult.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw json.decode(response.body)['error']['message'];
  //   }
  // }

  // Future<User> load(String userId) async {
  //   late String baseUrl = getUrl();
  //   final response = await http.get(
  //     Uri.parse(baseUrl + '/users/' + userId),
  //     headers: GlobalData.buildHeader(),
  //   );
  //   if (response.statusCode == 200) {
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw json.decode(response.body)['error']['message'];
  //   }
  // }

  // Future<ResultInfo<User>> update(User user) async {
  //   late String baseUrl = getUrl();
  //   final response = await http.patch(
  //     Uri.parse(baseUrl + '/users/' + user.userId),
  //     headers: GlobalData.buildHeader(),
  //     body: jsonEncode(<String, dynamic>{
  //       'userId': user.userId,
  //       'displayName': user.displayName,
  //       'title': user.title,
  //       'position': user.position,
  //       'phone': user.phone,
  //       'email': user.email,
  //       'gender': user.gender,
  //       'status': user.status,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     return ResultInfo.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw json.decode(response.body)['error']['message'];
  //   }
  // }
}
