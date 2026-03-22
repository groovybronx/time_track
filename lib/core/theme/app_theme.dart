import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ─── Tokens Couleurs ────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF0A1F44); // deep-blue
  static const Color accent = Color(0xFF007BFF); // bright-blue (action)
  static const Color danger = Color(0xFFDC3545); // red (stop)
  static const Color bgLight = Color(0xFFF8F9FA); // gray-50
  static const Color bgDark = Color(0xFF121212); // black-900

  // ─── Tokens Glass Morphism ──────────────────────────────────────────────────
  static Color glassBgLight = Colors.white.withValues(alpha: 0.6);
  static Color glassBgDark = Colors.black.withValues(alpha: 0.4);
  static const double glassBlur = 20.0;
  static const Color glassBorder = Colors.white24;

  // ─── Thème Lumineux (macOS) ─────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: accent,
        secondary: primary,
        surface: bgLight,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      cardTheme: CardThemeData(
        color: glassBgLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: glassBorder),
        ),
      ),
    );
  }

  // ─── Thème Sombre (Android) ──────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: bgDark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        color: Color(0x66000000), // glassBgDark — noir 40%
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: glassBorder),
        ),
      ),
    );
  }

  // ─── Utilitaire : Glass Card ──────────────────────────────────────────────────
  static Widget glassCard({required Widget child, Color? bgColor}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? glassBgLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: glassBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: child,
      ),
    );
  }
}
