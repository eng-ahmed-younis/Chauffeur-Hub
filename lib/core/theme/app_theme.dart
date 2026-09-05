import 'color/app_colors.dart';
import 'app_theme_extension.dart';

import 'package:flutter/material.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get light => _buildTheme(
    brightness: Brightness.light,
    background: AppColors.grey50,
    text: AppColors.grey900Text,
    mutedText: AppColors.grey700,
    surface: AppColors.lightWhite,
    border: AppColors.grey400,
    buttonBorder: AppColors.grey400Divider,
    colors: AppThemeColorsData.light,
  );

  static ThemeData get dark => _buildTheme(
    brightness: Brightness.dark,
    // background: AppColors.grey900Text,
    // text: AppColors.lightWhite,
    // mutedText: AppColors.grey300,
    // surface: AppColors.grey800,
    // border: AppColors.grey700,
    // buttonBorder: AppColors.grey500,
    // colors: AppThemeColorsData.light,
    background: AppColors.grey50,
    text: AppColors.grey900Text,
    mutedText: AppColors.grey700,
    surface: AppColors.lightWhite,
    border: AppColors.grey400,
    buttonBorder: AppColors.grey400Divider,
    colors: AppThemeColorsData.light,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color text,
    required Color mutedText,
    required Color surface,
    required Color border,
    required Color buttonBorder,
    required AppThemeColors colors,
  }) {
    final isLight = brightness == Brightness.light;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue100,
          brightness: brightness,
        ).copyWith(
          primary: AppColors.primaryBlue100,
          onPrimary: AppColors.lightWhite,
          surface: background,
          onSurface: text,
        );

    final textTheme = ThemeData(brightness: brightness).textTheme
        .apply(bodyColor: text, displayColor: text)
        .copyWith(
          bodySmall: TextStyle(color: mutedText),
          labelSmall: TextStyle(color: mutedText),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      extensions: <ThemeExtension<dynamic>>[colors],
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue100,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          backgroundColor: AppColors.primaryBlue100,
          foregroundColor: AppColors.lightWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          foregroundColor: AppColors.secondaryGreen,
          side: BorderSide(color: buttonBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: border),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue100,
        foregroundColor: AppColors.lightWhite,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isLight ? AppColors.primaryBlue100 : surface,
        contentTextStyle: const TextStyle(color: AppColors.lightWhite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
    );
  }
}
