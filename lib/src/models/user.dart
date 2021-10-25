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
    this.roles,
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
  List<String>? roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['userId'] ?? json['userid'],
        json['username'] != null ? json['username'] : '',
        json['email'],
        json['displayName'] ?? json['displayname'],
        json['imageURL'] ?? json['imageurl'],
        json['status'],
        json['gender'] != null ? json['gender'] : '',
        json['phone'] != null ? json['phone'] : '',
        json['title'] != null ? json['title'] : '',
        json['position'] != null ? json['position'] : '',
        json['roles'],
      );

  // factory User.fromJsonSQL(Map<String, dynamic> json) => User(
  //       json['userid'] != null ? json['userid'] : '',
  //       json['username'],
  //       json['email'],
  //       json['displayname'],
  //       json['imageurl'],
  //       json['status'],
  //       json['gender'],
  //       json['phone'],
  //       json['title'],
  //       json['position'],
  //     );
}
