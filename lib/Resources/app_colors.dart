import 'package:flutter/material.dart';

class App_Colors {
  // Primary Theme Colors
  static const Color primary = Color(0xFF6A0572); // Deep Purple
  static const Color secondary = Color(0xFFFFC107); // Amber
  static const Color accent = Color(0xFF00BCD4); // Cyan

// Custom Shades
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF6A0572, // Base Color
    <int, Color>{
      50: Color(0xFFF3E5F5), // Lightest
      100: Color(0xFFE1BEE7),
      200: Color(0xFFCE93D8),
      300: Color(0xFFBA68C8),
      400: Color(0xFFAB47BC),
      500: Color(0xFF9C27B0), // Base (Primary)
      600: Color(0xFF8E24AA),
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A0572), // Dark
      900: Color(0xFF4A148C), // Darkest
    },
  );

  // Background & Neutral Colors
  static const Color background = Color(0xFFD56408);
  static const Color cardColor = Color(0xFFF8BBD0); // Light Pink
  static const Color error = Color(0xFFD32F2F); // Red
}
