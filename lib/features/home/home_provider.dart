import 'package:flutter/material.dart';
import 'package:flutter_admin/features/login/auth_model.dart';

class AuthInheritedWidget extends InheritedWidget {
  AuthInheritedWidget({required Widget child, required this.authData})
      : super(child: child);

  final AuthInfo authData;

  @override
  bool updateShouldNotify(AuthInheritedWidget oldWidget) {
    return false;
  }

  static AuthInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthInheritedWidget>();
  }
}
