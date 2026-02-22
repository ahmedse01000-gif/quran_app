import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Colors
  static const Color primaryColor = Color(0xFF047857); // Emerald Green
  static const Color secondaryColor = Color(0xFFD4AF37); // Golden Yellow
  static const Color lightBackground = Color(0xFFFDFBF7); // Off-White/Cream
  static const Color darkBackground = Color(0xFF0F172A); // Deep Navy Blue
  static const Color lightText = Color(0xFF000000); // Black
  static const Color darkText = Color(0xFFFFFFFF); // White

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.amiri(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      displayMedium: GoogleFonts.amiri(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      displaySmall: GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      headlineMedium: GoogleFonts.amiri(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: lightText,
      ),
      headlineSmall: GoogleFonts.amiri(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      titleLarge: GoogleFonts.amiri(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      bodyLarge: GoogleFonts.amiri(
        fontSize: 18,
        color: lightText,
      ),
      bodyMedium: GoogleFonts.amiri(
        fontSize: 16,
        color: lightText,
      ),
      bodySmall: GoogleFonts.amiri(
        fontSize: 14,
        color: lightText,
      ),
      labelLarge: GoogleFonts.amiri(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: lightBackground,
      error: Colors.red,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.amiri(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkText,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.amiri(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      displayMedium: GoogleFonts.amiri(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      displaySmall: GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      headlineMedium: GoogleFonts.amiri(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
      headlineSmall: GoogleFonts.amiri(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      titleLarge: GoogleFonts.amiri(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      bodyLarge: GoogleFonts.amiri(
        fontSize: 18,
        color: darkText,
      ),
      bodyMedium: GoogleFonts.amiri(
        fontSize: 16,
        color: darkText,
      ),
      bodySmall: GoogleFonts.amiri(
        fontSize: 14,
        color: darkText,
      ),
      labelLarge: GoogleFonts.amiri(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: darkBackground,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: darkBackground,
      error: Colors.red,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.amiri(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
