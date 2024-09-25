import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.oswald().fontFamily,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    surfaceContainerHigh: const Color.fromARGB(255, 182, 182, 182),
  ),
);


final darkTheme = ThemeData(
  fontFamily: GoogleFonts.oswald().fontFamily,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    // primaryContainer: const Color.fromARGB(255, 245, 245, 245),
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
    surfaceContainerHigh: const Color.fromARGB(255, 73, 73, 73),
  ),
);