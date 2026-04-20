import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFFF5A5F);
  static const Color primaryDark = Color(0xFFE04850);
  static const Color textPrimary = Color(0xFF484848);
  static const Color textSecondary = Color(0xFF767676);
  static const Color background = Color(0xFFF7F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);
  static const Color rating = Color(0xFFFFB400);
  static const Color cardSurface = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
      textTheme: baseTextTheme.copyWith(
        // H1 — 32px
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.25,
        ),
        // H2 — 24px
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.33,
        ),
        // H3 — 20px
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        // Body — 12px
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        // Body Medium weight — 12px
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        // Price — 16px
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          height: 1.5,
        ),
        // Caption — 12px secondary
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        // Button text — 16px
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.surface,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}
