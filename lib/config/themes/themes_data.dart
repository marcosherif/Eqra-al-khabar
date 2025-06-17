import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xffc1121f),
  cardColor: Colors.white,
  scaffoldBackgroundColor: Colors.blueGrey.shade50,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Text/icon color
      backgroundColor: Color(0xffc1121f), // Button background color
    ),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey.shade50),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color(0xff023047)),
    bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: Colors.white),
    headlineSmall: GoogleFonts.rubik(
      color: Color(0xff002137),
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(color: Color(0xffc1121f)),
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xff0096c7),
  cardColor: Color(0xff003A61),
  scaffoldBackgroundColor: Color(0xff00111C),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Text/icon color
      backgroundColor: Color(0xff0096c7), // Button background color
    ),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff00111C)),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    headlineSmall: GoogleFonts.rubik(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(color: Color(0xffc1121f)),
  ),
);
