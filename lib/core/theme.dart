import 'package:flutter/material.dart';
import 'constants.dart';
final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: WrestlingColors.color_background,
    iconTheme: IconThemeData(color: WrestlingColors.color_red),
    actionsIconTheme: IconThemeData(color: WrestlingColors.color_red)
  ),
  scaffoldBackgroundColor: WrestlingColors.color_background,
  textTheme: const TextTheme(
    labelSmall:TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Crimson',
      fontSize: 14,
    ),
    labelLarge:TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Crimson',
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Crimson',
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      color: WrestlingColors.color_small_text,
      fontWeight: FontWeight.w700,
      fontFamily: 'Crimson',
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: WrestlingColors.color_small_text,
      fontWeight: FontWeight.w400,
      fontFamily: 'Crimson',
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Crimson',
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color:Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Crimson',
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Crimson',
      fontSize: 14,
    ),
  ),
  useMaterial3: true,
);
