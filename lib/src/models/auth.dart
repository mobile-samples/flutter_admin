class AuthInfo {
  AuthInfo(
      {required this.username,
      required this.displayName,
      required this.id,
      required this.privileges,
      required this.token,
      required this.tokenExpiredTime});
  String username;
  String displayName;
  String id;
  List<Privileges> privileges;
  String token;
  String tokenExpiredTime;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
      username: json['username'],
      displayName: json['displayName'],
      id: json['id'],
      privileges: List<Privileges>.from(json['privileges'] == null
          ? []
          : json['privileges'].map((x) => Privileges.fromJson(x))),
      token: json['token'],
      tokenExpiredTime: json['tokenExpiredTime']);
}

class Privileges {
  Privileges({
    required this.children,
    required this.icon,
    required this.id,
    required this.name,
    required this.path,
    required this.permissions,
    required this.resource,
  });
  List<Privileges> children;
  String icon;
  String id;
  String name;
  String path;
  int permissions;
  String resource;

  factory Privileges.fromJson(Map<String, dynamic> json) => Privileges(
        children: List<Privileges>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privileges.fromJson(x))),
        icon: json['icon'] != null ? json['icon'] : '',
        id: json['id'],
        name: json['name'],
        path: json['path'],
        permissions:
            json['permission'].toString().length > 0 ? json['permissions'] : 0,
        resource: json['resource'],
      );
}
