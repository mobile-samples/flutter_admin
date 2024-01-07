import 'package:flutter/material.dart';
import 'package:flutter_admin/common/app_theme.dart';
import 'package:flutter_admin/features/login/login.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: getAppTheme(context, false),
    );
  }
}
