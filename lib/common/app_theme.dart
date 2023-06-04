import 'package:flutter/material.dart';

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: Colors.green,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
    textTheme: Theme.of(context).textTheme.copyWith(
          titleLarge: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 48,
            fontWeight: FontWeight.w800,
          ),
          titleMedium: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
    colorScheme: Theme.of(context).colorScheme.copyWith(
          background: isDarkTheme ? Colors.black : Colors.white,
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      minimumSize: const Size(double.infinity, 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber,
      textStyle: const TextStyle(
        color: Colors.green,
      ),
      minimumSize: const Size(double.infinity, 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    )),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.green[200],
    ),
  );
}
