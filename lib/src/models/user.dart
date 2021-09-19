class Signin {
  Signin({required this.username, required this.password});
  String username;
  String password;
}

class User {
  User({
    required this.username,
    required this.userId,
    required this.displayName,
    required this.title,
    required this.status,
    required this.phone,
    required this.email,
    required this.position,
    required this.gender,
    required this.imageURL,
    this.createdAt,
    this.createdBy,
    this.lastLogin,
    this.updatedAt,
    this.updatedBy,
  });
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
  String? createdAt;
  String? createdBy;
  String? lastLogin;
  String? updatedAt;
  String? updatedBy;

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      userId: json['userId'] != null ? json['userId'] : '',
      displayName: json['displayName'],
      title: json['title'],
      status: json['status'],
      phone: json['phone'],
      email: json['email'],
      position: json['position'],
      gender: json['gender'],
      imageURL: json['imageURL'],
      createdAt: json['createdAt'] != null ? json['createdAt'].toString() : '',
      createdBy: json['createdBy'] != null ? json['createdBy'] : '',
      lastLogin: json['lastLogin'] != null ? json['lastLogin'] : '',
      updatedAt: json['updatedAt'] != null ? json['updatedAt'] : '',
      updatedBy: json['updatedBy'] != null ? json['updatedBy'] : '');
}

class ListUsers {
  ListUsers({required this.list, required this.total});
  List<User> list;
  int total;

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
      list: List<User>.from(json['list'].map((x) => User.fromJson(x))),
      total: json['total']);
}

class UserSQL {
  UserSQL({
    required this.username,
    required this.userId,
    required this.displayName,
    required this.title,
    required this.status,
    required this.phone,
    required this.email,
    required this.position,
    required this.gender,
    required this.imageURL,
    this.createdAt,
    this.createdBy,
    this.lastLogin,
    this.updatedAt,
    this.updatedBy,
  });
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
  String? createdAt;
  String? createdBy;
  String? lastLogin;
  String? updatedAt;
  String? updatedBy;

  factory UserSQL.fromJson(Map<String, dynamic> json) => UserSQL(
      username: json['username'],
      userId: json['userid'] != null ? json['userid'] : '',
      displayName: json['displayname'],
      title: json['title'],
      status: json['status'],
      phone: json['phone'],
      email: json['email'],
      position: json['position'],
      gender: json['gender'],
      imageURL: json['imageurl'],
      createdAt: json['createdat'] != null ? json['createdat'].toString() : '',
      createdBy: json['createdby'] != null ? json['createdby'] : '',
      lastLogin: json['lastlogin'] != null ? json['lastlogin'] : '',
      updatedAt: json['updatedat'] != null ? json['updatedat'] : '',
      updatedBy: json['updatedby'] != null ? json['updatedby'] : '');
}

class ListUsersSQL {
  ListUsersSQL({required this.list, required this.total});
  List<UserSQL> list;
  int total;

  factory ListUsersSQL.fromJson(Map<String, dynamic> json) => ListUsersSQL(
      list: List<UserSQL>.from(json['list'].map((x) => UserSQL.fromJson(x))),
      total: json['total']);
}
