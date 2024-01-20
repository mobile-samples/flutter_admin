import 'package:flutter/material.dart';

class AppTheme {
  Color lightPrimaryColor = Colors.green;
  Color dartPrimaryColor = Colors.green;
  Color secondaryColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
      backgroundColor: Colors.green,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    ),
    cardTheme: ThemeData.light().cardTheme.copyWith(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(10)
    ),
    checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
      checkColor: MaterialStateProperty.all(Colors.white),
    ),
    colorScheme: ThemeData.light().colorScheme.copyWith(
      background: Colors.white,
    ),
    dialogTheme: ThemeData.light().dialogTheme.copyWith(
      backgroundColor: Colors.green[200],
    ),
    dropdownMenuTheme: ThemeData.light().dropdownMenuTheme.copyWith(
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
        ),
        minimumSize: const Size(double.infinity, 40),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        textStyle: const TextStyle(
          fontSize: 20,
        ),
        minimumSize: const Size(double.infinity, 40),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      )
    ),
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      hintStyle: const TextStyle(
        height: 2,
        // fontSize: 20,
        color: Colors.black
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(TextStyle(
          color: Colors.green,
          fontSize: 16,
        )),
      ),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
      headlineLarge: TextStyle(
        color: _appTheme.lightPrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.w900,
      ),
      headlineMedium: const TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w800,
      ),
      titleLarge: TextStyle(
        color: _appTheme.lightPrimaryColor,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
      titleMedium: TextStyle(
        color: _appTheme.secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodySmall: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
  );
}

AppTheme _appTheme = AppTheme();