class AuthInfo {
  AuthInfo(
    this.username,
    this.displayName,
    this.id,
    this.privileges,
    this.token,
    this.tokenExpiredTime,
  );
  String username;
  String displayName;
  String id;
  List<Privileges> privileges;
  String token;
  String tokenExpiredTime;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
      json['username'],
      json['displayName'],
      json['id'],
      List<Privileges>.from(json['privileges'] == null
          ? []
          : json['privileges'].map((x) => Privileges.fromJson(x))),
      json['token'],
      json['tokenExpiredTime']);
}

class Privileges {
  Privileges(
    this.children,
    this.icon,
    this.id,
    this.name,
    this.path,
    this.permissions,
    this.resource,
  );
  List<Privileges> children;
  String icon;
  String id;
  String name;
  String path;
  int permissions;
  String resource;

  factory Privileges.fromJson(Map<String, dynamic> json) => Privileges(
        List<Privileges>.from(json['children'] == null
            ? []
            : json['children'].map((x) => Privileges.fromJson(x))),
        json['icon'] != null ? json['icon'] : '',
        json['id'],
        json['name'],
        json['path'],
        json['permission'].toString().length > 0 ? json['permissions'] : 0,
        json['resource'],
      );
}
