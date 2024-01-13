import 'package:flutter/material.dart';
import 'package:flutter_admin/features/login/auth_model.dart';

class AuthInheritedWidget extends InheritedWidget {
  const AuthInheritedWidget({super.key, required super.child, required this.authData});
  final AuthInfo authData;

  @override
  bool updateShouldNotify(AuthInheritedWidget oldWidget) {
    return false;
  }

  static AuthInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthInheritedWidget>();
  }
}
