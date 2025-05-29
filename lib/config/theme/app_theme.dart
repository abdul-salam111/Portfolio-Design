import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF66FCF2);
  static const Color darkBackgroundColor = Color(0xFF18191A);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightModePrimaryColor =
      Color.fromARGB(255, 28, 151, 143);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      surface: darkBackgroundColor,
      onPrimary: Colors.black,
      onSurface: Colors.white,
    ),
    textTheme: ThemeData.dark().textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightModePrimaryColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    colorScheme: const ColorScheme.light(
      primary: lightModePrimaryColor,
      surface: lightBackgroundColor,
      onPrimary: Colors.black,
      onSurface: Colors.black,
    ),
    textTheme: ThemeData.light().textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackgroundColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightModePrimaryColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
