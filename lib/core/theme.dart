import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: AppColors.colorBackground,
    iconTheme: IconThemeData(color: AppColors.colorRed),
    actionsIconTheme: IconThemeData(color: AppColors.colorRed)
  ),
  scaffoldBackgroundColor: AppColors.colorBackground,
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
      color: AppColors.colorSmallText,
      fontWeight: FontWeight.w700,
      fontFamily: 'Crimson',
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: AppColors.colorSmallText,
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
