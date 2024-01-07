import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/features/role/role_model.dart';
import 'package:flutter_admin/utils/global_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class RoleService extends Client<Role, String, ResultInfo<Role>, RoleFilter> {
  static final RoleService instance = RoleService._instantiate();

  final String baseUrlIOS = 'http://localhost:8083';
  final String baseUrlAndroid = 'http://10.0.2.2:8083';

  RoleService._instantiate()
      : super(
          serviceUrl: Platform.isIOS
              ? 'http://localhost:8083/roles'
              : 'http://10.0.2.2:8083/roles',
          createObjectFromJson: Role.fromJson,
          getId: Role.getId,
        );

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    }
  }

  Future<List<Privilege>> getPrivileges() async {
    late String baseUrl = getUrl();
    final response = await http.get(
      Uri.parse('$baseUrl/privileges'),
      headers: GlobalData.buildHeader(),
    );
    if (response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body);
      List<Privilege> privilegeList = [];
      res.forEach((item) {
        privilegeList.add(Privilege.fromJson(item));
      });
      return privilegeList;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
