import 'package:flutter/material.dart';

/// Color tokens for the portfolio. Dark is the primary, default palette;
/// light is a full second palette, not just an inversion.
class AppColors {
  const AppColors._();

  // Shared accent — kept identical across themes for brand consistency.
  static const Color accent = Color(0xFFFF7A3D);
  static const Color accentSecondary = Color(0xFFFFB648);

  // Dark palette — warm charcoal undertone instead of a cool navy, so the
  // neutrals sit with the orange accent rather than fighting it.
  static const Color darkBackground = Color(0xFF15100D);
  static const Color darkSurface = Color(0xFF1F1812);
  static const Color darkSurfaceAlt = Color(0xFF2A2019);
  static const Color darkTextPrimary = Color(0xFFF7F1EA);
  static const Color darkTextSecondary = Color(0xFFB8AC9E);
  static const Color darkBorder = Color(0xFF3A2E24);

  // Light palette — warm off-white undertone to match.
  static const Color lightBackground = Color(0xFFFBF6F1);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF3E9DE);
  static const Color lightTextPrimary = Color(0xFF221A13);
  static const Color lightTextSecondary = Color(0xFF6E6155);
  static const Color lightBorder = Color(0xFFE6D9C9);
}
