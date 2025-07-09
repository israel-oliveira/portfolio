import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color accentColor = Color(0xFF10B981);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color darkBackgroundColor = Color(0xFF0F172A);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color darkSurfaceColor = Color(0xFF1E293B);
  static const Color textColor = Color(0xFF1F2937);
  static const Color darkTextColor = Color(0xFFF1F5F9);
  static const Color secondaryTextColor = Color(0xFF6B7280);
  static const Color darkSecondaryTextColor = Color(0xFF94A3B8);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      textTheme: _textTheme(textColor, secondaryTextColor),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: accentColor,
        surface: darkSurfaceColor,
        background: darkBackgroundColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: darkTextColor),
      ),
      textTheme: _textTheme(darkTextColor, darkSecondaryTextColor),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black54,
        color: darkSurfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(
        color: primary,
        fontSize: 64,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        color: primary,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
      displaySmall: TextStyle(
        color: primary,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
      headlineLarge: TextStyle(
        color: primary,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      headlineMedium: TextStyle(
        color: primary,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      headlineSmall: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleLarge: TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        color: secondary,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.6,
      ),
      labelLarge: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        color: secondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        color: secondary,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }
}
