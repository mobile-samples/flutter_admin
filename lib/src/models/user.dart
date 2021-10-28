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

  Map<String, dynamic> toMap() => {
        // 'userid': user.userId,
        'displayname': displayName,
        'title': title,
        'position': position,
        'phone': phone,
        'email': email,
        'gender': gender,
        'status': status,
      };

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
        json['roles']?.cast<String>(),
      );
}
