import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeManager instance = ThemeManager._internal();

  factory ThemeManager() {
    return instance;
  }

  ThemeManager._internal();

  final Color containerBlack = const Color(0xff2C2C2C);
  final Color black = const Color(0xff3D3D3E);
  final Color primaryLightBackgroundColor = const Color(0xffF1EFE5);
  final Color white = const Color(0xffE7E3CF);

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: black,
      scaffoldBackgroundColor: white,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
        bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
        bodySmall: GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: white,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: white,
      scaffoldBackgroundColor: black,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
        bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.white70),
        bodySmall: GoogleFonts.roboto(fontSize: 14, color: Colors.white60),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: black,
        selectedItemColor: white,
        unselectedItemColor: Colors.grey,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: black,
      ),
    );
  }
}
