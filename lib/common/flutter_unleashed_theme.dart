import 'package:flutter/material.dart';

final flutterUnleashedTheme = ThemeData(
  colorScheme: colorScheme,
  primaryColor: colorScheme.primary,
  accentColor: Color(0xFF4D5EAB),
  backgroundColor: colorScheme.background,
  scaffoldBackgroundColor: colorScheme.background,
);

final ColorScheme colorScheme = ColorScheme.light(
    primary: Color(0xFF4D5EAB),
    primaryVariant: Color(0xFF3A4579),
    secondary: Color(0xFFea9f42),
    secondaryVariant: Color(0xFFCA8838),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    error: Color(0xFF000000),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFFF72866),
    brightness: Brightness.light);
