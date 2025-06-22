import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xffc1121f),
  cardColor: Colors.white,
  scaffoldBackgroundColor: Color(0xfff0f4f8),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Text/icon color
      backgroundColor: Color(0xffc1121f), // Button background color
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xffc1121f)),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xfff0f4f8), elevation: 0),
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
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xffc1121f)),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff00111C), elevation: 0),
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

List<List<Color>> generateGradients(List<Color> baseColors) {
  return baseColors.map((color) {
    final hsl = HSLColor.fromColor(color);
    final lighter =
        hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0)).toColor();
    return [color, lighter];
  }).toList();
}

final List<Color> lightBaseColors = [
  Color(0xff780000),
  Color(0xffC1121F),
  Color(0xffECA400),
  Color(0xffFA9F42),
  Color(0xff003049),
  Color(0xff669BBC),
];

final List<Color> darkBaseColors = [
  Color(0xff8ecae6),
  Color(0xff219EBC),
  Color(0xff870058),
  Color(0xffff006e),
  Color(0xffFFB703),
  Color(0xffFB8500),
];

final gridTilesBrightGradients = generateGradients(lightBaseColors);
final gridTilesDarkGradients = generateGradients(darkBaseColors);
