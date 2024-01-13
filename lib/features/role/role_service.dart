import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/features/role/role_model.dart';
import 'package:flutter_admin/utils/http_helper.dart';

class RoleService extends Client<Role, String, RoleFilter> {
  static final RoleService instance = RoleService._instantiate();

  RoleService._instantiate()
      : super(
          serviceUrl: HttpHelper.instance.getUrl() + '/roles',
          fromJson: Role.fromJson,
          getId: Role.getId,
        );

  Future<List<Privilege>> getPrivileges() async {
    late String baseUrl = HttpHelper.instance.getUrl();
    final headers = await HttpHelper.instance.buildHeader();
    final response = await http.get(
      Uri.parse('$baseUrl/privileges'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
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
