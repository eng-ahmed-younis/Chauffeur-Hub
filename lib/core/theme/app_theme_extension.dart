import 'color/app_colors.dart';
import 'package:flutter/material.dart';


@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    this.lightWhite = AppColors.lightWhite,
    this.lightBlack = AppColors.lightBlack,
    this.grey50 = AppColors.grey50,
    this.grey100 = AppColors.grey100,
    this.grey200 = AppColors.grey200,
    this.grey300 = AppColors.grey300,
    this.grey400 = AppColors.grey400,
    this.grey400Divider = AppColors.grey400Divider,
    this.grey500 = AppColors.grey500,
    this.grey600 = AppColors.grey600,
    this.grey700 = AppColors.grey700,
    this.grey800 = AppColors.grey800,
    this.grey900Text = AppColors.grey900Text,
    this.primaryBlue100 = AppColors.primaryBlue100,
    this.primaryBlue200 = AppColors.primaryBlue200,
    this.lightBlue100 = AppColors.lightBlue100,
    this.lightBlue200 = AppColors.lightBlue200,
    this.brightBlue100 = AppColors.brightBlue100,
    this.yellow100 = AppColors.yellow100,
    this.yellow200 = AppColors.yellow200,
    this.secondaryGreen = AppColors.secondaryGreen,
    this.systemYellowBright = AppColors.systemYellowBright,
    this.systemYellowPastel = AppColors.systemYellowPastel,
    this.systemOrangeBright = AppColors.systemOrangeBright,
    this.systemOrangePastel = AppColors.systemOrangePastel,
    this.systemRedBright = AppColors.systemRedBright,
    this.systemRedPastel = AppColors.systemRedPastel,
    this.systemGreenBright = AppColors.systemGreenBright,
    this.systemGreenPastel = AppColors.systemGreenPastel,
    this.systemBlueBright = AppColors.systemBlueBright,
  });

  final Color lightWhite;
  final Color lightBlack;
  final Color grey50;
  final Color grey100;
  final Color grey200;
  final Color grey300;
  final Color grey400;
  final Color grey400Divider;
  final Color grey500;
  final Color grey600;
  final Color grey700;
  final Color grey800;
  final Color grey900Text;
  final Color primaryBlue100;
  final Color primaryBlue200;
  final Color lightBlue100;
  final Color lightBlue200;
  final Color brightBlue100;
  final Color yellow100;
  final Color yellow200;
  final Color secondaryGreen;
  final Color systemYellowBright;
  final Color systemYellowPastel;
  final Color systemOrangeBright;
  final Color systemOrangePastel;
  final Color systemRedBright;
  final Color systemRedPastel;
  final Color systemGreenBright;
  final Color systemGreenPastel;
  final Color systemBlueBright;
  @override
  AppThemeColors copyWith({
    Color? lightWhite,
    Color? lightBlack,
    Color? grey50,
    Color? grey100,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey400Divider,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? grey900Text,
    Color? primaryBlue100,
    Color? primaryBlue200,
    Color? lightBlue100,
    Color? lightBlue200,
    Color? brightBlue100,
    Color? yellow100,
    Color? yellow200,
    Color? secondaryGreen,
    Color? systemYellowBright,
    Color? systemYellowPastel,
    Color? systemOrangeBright,
    Color? systemOrangePastel,
    Color? systemRedBright,
    Color? systemRedPastel,
    Color? systemGreenBright,
    Color? systemGreenPastel,
    Color? systemBlueBright,
  }) {
    return AppThemeColors(
      lightWhite: lightWhite ?? this.lightWhite,
      lightBlack: lightBlack ?? this.lightBlack,
      grey50: grey50 ?? this.grey50,
      grey100: grey100 ?? this.grey100,
      grey200: grey200 ?? this.grey200,
      grey300: grey300 ?? this.grey300,
      grey400: grey400 ?? this.grey400,
      grey400Divider: grey400Divider ?? this.grey400Divider,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      grey900Text: grey900Text ?? this.grey900Text,
      primaryBlue100: primaryBlue100 ?? this.primaryBlue100,
      primaryBlue200: primaryBlue200 ?? this.primaryBlue200,
      lightBlue100: lightBlue100 ?? this.lightBlue100,
      lightBlue200: lightBlue200 ?? this.lightBlue200,
      brightBlue100: brightBlue100 ?? this.brightBlue100,
      yellow100: yellow100 ?? this.yellow100,
      yellow200: yellow200 ?? this.yellow200,
      secondaryGreen: secondaryGreen ?? this.secondaryGreen,
      systemYellowBright: systemYellowBright ?? this.systemYellowBright,
      systemYellowPastel: systemYellowPastel ?? this.systemYellowPastel,
      systemOrangeBright: systemOrangeBright ?? this.systemOrangeBright,
      systemOrangePastel: systemOrangePastel ?? this.systemOrangePastel,
      systemRedBright: systemRedBright ?? this.systemRedBright,
      systemRedPastel: systemRedPastel ?? this.systemRedPastel,
      systemGreenBright: systemGreenBright ?? this.systemGreenBright,
      systemGreenPastel: systemGreenPastel ?? this.systemGreenPastel,
      systemBlueBright: systemBlueBright ?? this.systemBlueBright,
    );
  }

  @override
  AppThemeColors lerp(
    covariant ThemeExtension<AppThemeColors>? other,
    double t,
  ) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      lightWhite: Color.lerp(lightWhite, other.lightWhite, t)!,
      lightBlack: Color.lerp(lightBlack, other.lightBlack, t)!,
      grey50: Color.lerp(grey50, other.grey50, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey300: Color.lerp(grey300, other.grey300, t)!,
      grey400: Color.lerp(grey400, other.grey400, t)!,
      grey400Divider: Color.lerp(grey400Divider, other.grey400Divider, t)!,
      grey500: Color.lerp(grey500, other.grey500, t)!,
      grey600: Color.lerp(grey600, other.grey600, t)!,
      grey700: Color.lerp(grey700, other.grey700, t)!,
      grey800: Color.lerp(grey800, other.grey800, t)!,
      grey900Text: Color.lerp(grey900Text, other.grey900Text, t)!,
      primaryBlue100: Color.lerp(primaryBlue100, other.primaryBlue100, t)!,
      primaryBlue200: Color.lerp(primaryBlue200, other.primaryBlue200, t)!,
      lightBlue100: Color.lerp(lightBlue100, other.lightBlue100, t)!,
      lightBlue200: Color.lerp(lightBlue200, other.lightBlue200, t)!,
      brightBlue100: Color.lerp(brightBlue100, other.brightBlue100, t)!,
      yellow100: Color.lerp(yellow100, other.yellow100, t)!,
      yellow200: Color.lerp(yellow200, other.yellow200, t)!,
      secondaryGreen: Color.lerp(secondaryGreen, other.secondaryGreen, t)!,
      systemYellowBright: Color.lerp(
        systemYellowBright,
        other.systemYellowBright,
        t,
      )!,
      systemYellowPastel: Color.lerp(
        systemYellowPastel,
        other.systemYellowPastel,
        t,
      )!,
      systemOrangeBright: Color.lerp(
        systemOrangeBright,
        other.systemOrangeBright,
        t,
      )!,
      systemOrangePastel: Color.lerp(
        systemOrangePastel,
        other.systemOrangePastel,
        t,
      )!,
      systemRedBright: Color.lerp(systemRedBright, other.systemRedBright, t)!,
      systemRedPastel: Color.lerp(systemRedPastel, other.systemRedPastel, t)!,
      systemGreenBright: Color.lerp(
        systemGreenBright,
        other.systemGreenBright,
        t,
      )!,
      systemGreenPastel: Color.lerp(
        systemGreenPastel,
        other.systemGreenPastel,
        t,
      )!,
      systemBlueBright: Color.lerp(
        systemBlueBright,
        other.systemBlueBright,
        t,
      )!,
    );
  }
}

final class AppThemeColorsData {
    const AppThemeColorsData._();

    static const light = AppThemeColors(
      lightWhite: AppColors.lightWhite,
      lightBlack: AppColors.lightBlack,
      grey50: AppColors.grey50,
      grey100: AppColors.grey100,
      grey200: AppColors.grey200,
      grey300: AppColors.grey300,
      grey400: AppColors.grey400,
      grey400Divider: AppColors.grey400Divider,
      grey500: AppColors.grey500,
      grey600: AppColors.grey600,
      grey700: AppColors.grey700,
      grey800: AppColors.grey800,
      grey900Text: AppColors.grey900Text,
      primaryBlue100: AppColors.primaryBlue100,
      primaryBlue200: AppColors.primaryBlue200,
      lightBlue100: AppColors.lightBlue100,
      lightBlue200: AppColors.lightBlue200,
      brightBlue100: AppColors.brightBlue100,
      yellow100: AppColors.yellow100,
      yellow200: AppColors.yellow200,
      secondaryGreen: AppColors.secondaryGreen,
      systemYellowBright: AppColors.systemYellowBright,
      systemYellowPastel: AppColors.systemYellowPastel,
      systemOrangeBright: AppColors.systemOrangeBright,
      systemOrangePastel: AppColors.systemOrangePastel,
      systemRedBright: AppColors.systemRedBright,
      systemRedPastel: AppColors.systemRedPastel,
      systemGreenBright: AppColors.systemGreenBright,
      systemGreenPastel: AppColors.systemGreenPastel,
      systemBlueBright: AppColors.systemBlueBright,
    );
}

