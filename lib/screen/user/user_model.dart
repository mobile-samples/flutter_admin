import 'package:flutter_admin/common/client/model.dart';

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

  Map<String, dynamic> toJson() => {
        // 'userid': user.userId,
        'displayname': displayName,
        'title': title,
        'position': position,
        'phone': phone,
        'email': email,
        'gender': gender,
        'status': status,
        'username': username,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['userId'] ?? json['userid'],
        json['username'] ?? '',
        json['email'],
        json['displayName'] ?? json['displayname'],
        json['imageURL'] ?? json['imageurl'],
        json['status'],
        json['gender'] ?? '',
        json['phone'] ?? '',
        json['title'] ?? '',
        json['position'] ?? '',
        json['roles']?.cast<String>(),
      );

  static String getId(User user) => user.userId;
}

class UserFilter extends Filter {
  UserFilter(
    this.userId,
    this.username,
    this.email,
    this.displayName,
    this.status,
    int? limit,
    int? page,
  ) : super(limit, page);

  String? userId;
  String? username;
  String? email;
  String? displayName;
  List<String>? status;

  @override
  Map<String, dynamic> toJson() => {
        'username': username ?? '',
        'displayName': displayName ?? '',
        'status': status ?? [],
        'limit': limit ?? 0,
        'page': page ?? 0,
      };
}
