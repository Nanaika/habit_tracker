import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: 'oswald',
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    surfaceContainerHigh: const Color.fromARGB(255, 210, 210, 210),
    onSurfaceVariant: Colors.white,
  ),
  dividerTheme: const DividerThemeData(color: Colors.transparent),
);


final darkTheme = ThemeData(
  fontFamily: 'oswald',
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    // primaryContainer: const Color.fromARGB(255, 245, 245, 245),
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
    surfaceContainerHigh: const Color.fromARGB(255, 38, 38, 38),
      onSurfaceVariant: Colors.white,
  ),
  dividerTheme: const DividerThemeData(color: Colors.transparent),
);