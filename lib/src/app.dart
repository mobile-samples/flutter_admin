import 'package:flutter/material.dart';
import 'package:flutter_admin/src/screen/login.dart';
import 'package:flutter_admin/src/common/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: getAppTheme(context, false),
    );
  }
}
