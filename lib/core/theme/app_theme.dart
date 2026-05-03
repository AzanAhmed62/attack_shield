import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Color palette ─────────────────────────────────────────────────────────
  static const Color primaryColor    = Color(0xFF00D9FF); // Cyan
  static const Color primaryDark     = Color(0xFF0099CC);
  static const Color accentColor     = Color(0xFFFF3366); // Magenta-red
  static const Color successColor    = Color(0xFF00CC66); // Green
  static const Color warningColor    = Color(0xFFFFCC00); // Yellow
  static const Color dangerColor     = Color(0xFFFF3333); // Red
  // Dark backgrounds
  static const Color backgroundColor = Color(0xFF0A0E27);
  static const Color surfaceColor    = Color(0xFF1A1F3A);
  static const Color darkBg2         = Color(0xFF0F1419);
  // Light backgrounds
  static const Color lightBg         = Color(0xFFF4F6FA);
  static const Color lightSurface    = Color(0xFFFFFFFF);
  static const Color lightSurface2   = Color(0xFFEFF2F8);

  // ── Text theme (Outfit font) ──────────────────────────────────────────────

  static TextTheme _buildTextTheme({required bool dark}) {
    final base = dark ? Colors.white : const Color(0xFF0A0E27);
    final muted = dark ? const Color(0xFFBBBBBB) : const Color(0xFF555577);
    final subtle = dark ? const Color(0xFF999999) : const Color(0xFF888899);

    return GoogleFonts.outfitTextTheme(
      TextTheme(
        displayLarge:  const TextStyle(fontSize: 32, fontWeight: FontWeight.w700).copyWith(color: base),
        displayMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700).copyWith(color: base),
        displaySmall:  const TextStyle(fontSize: 24, fontWeight: FontWeight.w700).copyWith(color: base),
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: base),
        headlineMedium:TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: base),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: base),
        titleLarge:    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: base),
        titleMedium:   TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: base),
        titleSmall:    TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: muted),
        bodyLarge:     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: muted),
        bodyMedium:    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: muted),
        bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: subtle),
        labelLarge:    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor),
        labelMedium:   const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor),
        labelSmall:    TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: subtle),
      ),
    );
  }

  // ── Dark theme ────────────────────────────────────────────────────────────

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: _buildTextTheme(dark: true),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        error: dangerColor,
        tertiary: successColor,
        onPrimary: Colors.black,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkBg2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF333D5B), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF777788)),
        labelStyle: const TextStyle(color: primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.outfit(
              fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.outfit(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.outfit(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withValues(alpha: 0.08),
        labelStyle: GoogleFonts.outfit(
            fontSize: 12, color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF252A45),
        thickness: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFF666680),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: primaryColor.withValues(alpha: 0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor);
          }
          return const IconThemeData(color: Color(0xFF666680));
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
                fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor);
          }
          return GoogleFonts.outfit(
              fontSize: 11, color: const Color(0xFF666680));
        }),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
            primaryColor.withValues(alpha: 0.4)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceColor,
        contentTextStyle: GoogleFonts.outfit(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: GoogleFonts.outfit(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  // ── Light theme ───────────────────────────────────────────────────────────

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF006699),
      scaffoldBackgroundColor: lightBg,
      textTheme: _buildTextTheme(dark: false),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF006699),
        secondary: Color(0xFFCC0044),
        surface: lightSurface,
        error: Color(0xFFCC2200),
        tertiary: Color(0xFF007744),
        onPrimary: Colors.white,
        onSurface: Color(0xFF0A0E27),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0A0E27),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF0A0E27)),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface2,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF006699), width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFCCCCDD), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF006699), width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF999999)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF006699),
          foregroundColor: Colors.white,
          elevation: 0,
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          textStyle:
              GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: Color(0xFF006699),
        unselectedItemColor: Color(0xFF999999),
        type: BottomNavigationBarType.fixed,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightSurface,
        indicatorColor: const Color(0xFF006699).withValues(alpha: 0.12),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF006699),
        foregroundColor: Colors.white,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1A1F3A),
        contentTextStyle: GoogleFonts.outfit(color: Colors.white),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: lightSurface,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }
}
