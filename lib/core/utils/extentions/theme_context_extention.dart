import 'package:flutter/material.dart';
import 'package:chauffeur_hub/core/theme/app_theme_extension.dart';

/// Provides convenient access to custom [AppThemeColors]
/// from the current [Theme] using BuildContext.
///
/// Example:
/// ```dart
/// final colors = context.appColors;
/// ```
extension ThemeContextExtension on BuildContext {
  AppThemeColors get appColors => Theme.of(this).extension<AppThemeColors>()!;
}

/// Extension on [BuildContext] that provides easy access to [AppThemeColors].
///
/// - `on BuildContext` means this extension is available on any BuildContext.
/// - `appColors` is a getter, so it can be used like a property:
///   `final colors = context.appColors;`
/// - `Theme.of(this)` gets the current Flutter [ThemeData].
/// - `.extension<AppThemeColors>()` gets the registered custom theme extension.
/// - `!` asserts that [AppThemeColors] is registered; otherwise, the app throws
///   an error at runtime.
