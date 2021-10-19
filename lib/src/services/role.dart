import 'dart:convert';
import 'dart:io';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/utils/global_data.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class RoleService {
  RoleService._instantiate();

  static final RoleService instance = RoleService._instantiate();

  final String baseUrlIOS = 'http://localhost:8080';
  final String baseUrlAndroid = 'http://10.0.2.2:8080';

  getUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    }
  }

  Future<SearchResult<RoleSM>> search(RoleFilter filters) async {
    late String baseUrl = getUrl();
    final response = await http.post(
      Uri.parse(baseUrl + '/roles/search'),
      headers: GlobalData.buildHeader(),
      body: jsonEncode(<String, dynamic>{
        'roleName': filters.roleName.isNotEmpty ? filters.roleName : '',
        'status': filters.status.isNotEmpty ? filters.status : [],
        'limit': filters.limit.isNaN ? 0 : filters.limit,
        'page': filters.page.isNaN ? 0 : filters.page,
      }),
    );
    if (response.statusCode == 200) {
      return SearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Privilege>> getPrivileges() async {
    late String baseUrl = getUrl();
    final response = await http.get(
      Uri.parse(baseUrl + '/privileges'),
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

  Future<Role> load(String roleId) async {
    late String baseUrl = getUrl();
    final response = await http.get(
      Uri.parse(baseUrl + '/roles/' + roleId),
      headers: GlobalData.buildHeader(),
    );
    if (response.statusCode == 200) {
      return Role.fromJson(jsonDecode(response.body));
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<ResultInfo<Role>> put(Role role) async {
    late String baseUrl = getUrl();
    final response = await http.put(
      Uri.parse(baseUrl + '/roles/' + role.roleId),
      headers: GlobalData.buildHeader(),
      body: jsonEncode(<String, dynamic>{
        'createdBy': role.createdAt ?? "",
        'privileges': role.privileges,
        'remark': role.remark,
        'roleId': role.roleId,
        'roleName': role.roleName,
        'status': role.status,
      }),
    );
    if (response.statusCode == 200) {
      return ResultInfo.fromJson(jsonDecode(response.body));
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
