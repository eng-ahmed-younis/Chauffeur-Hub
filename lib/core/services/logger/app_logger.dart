import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Top-level helper function for simple logging.
void appLog(String key, Object? message) {
  AppLogger.log(key, message);
}

/// Enhanced logging service for Chauffeur Hub.
abstract final class AppLogger {
  static const String _defaultName = 'ChauffeurHub';

  /// Standard log
  static void log(String key, Object? message, {String name = _defaultName}) {
    if (kReleaseMode) return;
    final text = _formatMessage(key, message);
    debugPrint('[$name] $text');
    developer.log(text, name: name);
  }

  /// Info log ℹ️
  static void info(String key, Object? message, {String name = _defaultName}) {
    if (kReleaseMode) return;
    final text = 'ℹ️ ${_formatMessage(key, message)}';
    debugPrint('[$name] $text');
    developer.log(text, name: name, level: 800);
  }

  /// Debug log 🐛
  static void debug(String key, Object? message, {String name = _defaultName}) {
    if (kReleaseMode) return;
    final text = '🐛 ${_formatMessage(key, message)}';
    debugPrint('[$name] $text');
    developer.log(text, name: name, level: 500);
  }

  /// Warning log ⚠️
  static void warning(String key, Object? message, {String name = _defaultName}) {
    if (kReleaseMode) return;
    final text = '⚠️ ${_formatMessage(key, message)}';
    debugPrint('[$name] $text');
    developer.log(text, name: name, level: 900);
  }

  /// Success log ✅
  static void success(String key, Object? message, {String name = _defaultName}) {
    if (kReleaseMode) return;
    final text = '✅ ${_formatMessage(key, message)}';
    debugPrint('[$name] $text');
    developer.log(text, name: name, level: 800);
  }

  /// Error log ❌ with optional error object and stack trace
  static void error(
    String key,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    String name = _defaultName,
  }) {
    final text = '❌ ${_formatMessage(key, message)}';
    debugPrint('[$name] $text');
    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('StackTrace: $stackTrace');

    developer.log(
      text,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Format messages, auto pretty-printing Maps and JSON lists
  static String _formatMessage(String key, Object? message) {
    if (message is Map || message is List) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        final prettyJson = encoder.convert(message);
        return '$key:\n$prettyJson';
      } catch (_) {
        return '$key: $message';
      }
    }
    return '$key: $message';
  }
}
