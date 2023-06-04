import 'package:flutter/material.dart';

AppBar getAppBarWithArrowBack(BuildContext context, String title) {
  return AppBar(
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    title: Text(title),
  );
}
