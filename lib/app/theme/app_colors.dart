import 'package:flutter/material.dart';

/// Color tokens for the portfolio. Dark is the primary, default palette;
/// light is a full second palette, not just an inversion.
class AppColors {
  const AppColors._();

  // Shared accent — kept identical across themes for brand consistency.
  static const Color accent = Color(0xFF5B8DEF);
  static const Color accentSecondary = Color(0xFF22D3EE);

  // Dark palette
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF141A2B);
  static const Color darkSurfaceAlt = Color(0xFF1B2338);
  static const Color darkTextPrimary = Color(0xFFF4F6FB);
  static const Color darkTextSecondary = Color(0xFFAEB6C9);
  static const Color darkBorder = Color(0xFF2A3350);

  // Light palette
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEEF1F8);
  static const Color lightTextPrimary = Color(0xFF12162A);
  static const Color lightTextSecondary = Color(0xFF565F79);
  static const Color lightBorder = Color(0xFFDCE1EE);
}
