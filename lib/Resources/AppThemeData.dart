import 'package:flutter/material.dart';
import 'package:todo_app_udm/Resources/app_colors.dart';

class AppThemeData{
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: App_Colors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: App_Colors.secondary,
      foregroundColor: Colors.white,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: App_Colors.accent,
      focusElevation: 100,
      foregroundColor: App_Colors.error,
    ),
  );
}