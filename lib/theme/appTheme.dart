import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF6C63FF),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: const Color(0xFF101415),
    primaryColor: const Color(0xFFC5C5D7),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1D2022),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
