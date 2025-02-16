import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {

  Color containerBlack = const Color(0xff2C2C2C);
  Color black = const Color(0xff3D3D3E);
  Color primaryLightBackgroundColor = const Color(0xffF1EFE5);
  Color white = const Color(0xffE7E3CF);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xff3D3D3E), // Change as needed
      scaffoldBackgroundColor: Color(0xffE7E3CF),
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
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffE7E3CF),
      )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xffE7E3CF), // Change as needed
      scaffoldBackgroundColor: Color(0xff3D3D3E),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
        bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.white70),
        bodySmall: GoogleFonts.roboto(fontSize: 14, color: Colors.white60),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffE7E3CF),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff3D3D3E),
        selectedItemColor: Color(0xffE7E3CF),
        unselectedItemColor: Colors.grey,
      ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xff3D3D3E),
        )
    );
  }
}
