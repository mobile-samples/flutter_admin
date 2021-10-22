class Signin {
  Signin(
    this.username,
    this.password,
  );
  String username;
  String password;
}

class User {
  User(
    this.userId,
    this.username,
    this.email,
    this.displayName,
    this.imageURL,
    this.status,
    this.gender,
    this.phone,
    this.title,
    this.position,
    // this.roles,
  );

  String userId;
  String username;
  String email;
  String displayName;
  String? imageURL;
  String status;
  String? gender;
  String? phone;
  String? title;
  String? position;
  // List<String>? roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['userId'],
        json['username'] != null ? json['username'] : '',
        json['email'],
        json['displayName'],
        json['imageURL'] != null ? json['imageURL'] : '',
        json['status'],
        json['gender'] != null ? json['gender'] : '',
        json['phone'] != null ? json['phone'] : '',
        json['title'] != null ? json['title'] : '',
        json['position'] != null ? json['position'] : '',
        // List<String>.from(json['roles'] == null ? null : json['roles']),
      );
  // factory User.fromSQLJson(Map<String, dynamic> json) => User(
  //   json['userid'] != null ? json['userid'] : '',
  //   json['username'],
  //   json['email'],
  //   json['displayname'],
  //   json['imageurl'],
  //   json['status'],
  //   json['gender'],
  //   json['phone'],
  //   json['title'],
  //   json['position'],
  // );
}

class UserSQL {
  UserSQL(
    this.username,
    this.userId,
    this.displayName,
    this.title,
    this.status,
    this.phone,
    this.email,
    this.position,
    this.gender,
    this.imageURL,
    // this.createdAt,
    // this.createdBy,
    // this.lastLogin,
    // this.updatedAt,
    // this.updatedBy,
  );
  String username;
  String userId;
  String displayName;
  String title;
  String status;
  String phone;
  String email;
  String position;
  String gender;
  String imageURL;
  // String? createdAt;
  // String? createdBy;
  // String? lastLogin;
  // String? updatedAt;
  // String? updatedBy;

  factory UserSQL.fromJson(Map<String, dynamic> json) => UserSQL(
        json['username'],
        json['userid'] != null ? json['userid'] : '',
        json['displayname'],
        json['title'],
        json['status'],
        json['phone'],
        json['email'],
        json['position'],
        json['gender'],
        json['imageurl'],
      );
}

class ListUsersSQL {
  ListUsersSQL(this.list, this.total);
  List<UserSQL> list;
  int total;

  factory ListUsersSQL.fromJson(Map<String, dynamic> json) => ListUsersSQL(
      List<UserSQL>.from(json['list'].map((x) => UserSQL.fromJson(x))),
      json['total']);
}
