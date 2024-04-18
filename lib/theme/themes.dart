import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
    headlineMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
    bodySmall: TextStyle(),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  );
  static final _getButtonStyle = ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      minimumSize: WidgetStateProperty.all(
        const Size.fromHeight(56),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontWeight: FontWeight.w700),
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade400;
          }
          return Colors.teal;
        },
      ),
    ),
  );
  static _getAppbarTheme(Color foreground) => AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: foreground);
  static final _outlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: const BorderSide(color: Colors.teal, width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 16),
      minimumSize: const Size.fromHeight(56),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      foregroundColor: const Color.fromRGBO(0, 150, 136, 1),
      backgroundColor: Colors.transparent,
    ),
  );

  static _getTextButtonTheme(Color color) => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: color,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      );

  static _getInputTheme(Color borderColor) => InputDecorationTheme(
        errorMaxLines: 3,
        suffixIconColor: Colors.teal,
        prefixIconColor: Colors.teal,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: TextStyle(
          fontSize: 13,
          color: Colors.red.shade700,
          fontWeight: FontWeight.w500,
        ),
      );
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.teal,
    highlightColor: Colors.teal.shade400,
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.light,
    elevatedButtonTheme: _getButtonStyle,
    textButtonTheme: _getTextButtonTheme(Colors.teal.shade400),
    outlinedButtonTheme: _outlineButtonTheme,
    appBarTheme: _getAppbarTheme(Colors.black),
    textTheme: _textTheme.apply(
      displayColor: Colors.grey.shade900,
      bodyColor: Colors.grey.shade900,
    ),
    inputDecorationTheme: _getInputTheme(Colors.black),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    splashColor: Colors.teal,
    highlightColor: Colors.teal.shade400,
    colorSchemeSeed: Colors.teal,
    elevatedButtonTheme: _getButtonStyle,
    textTheme: _textTheme.apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    appBarTheme: _getAppbarTheme(Colors.white),
    outlinedButtonTheme: _outlineButtonTheme,
    inputDecorationTheme: _getInputTheme(Colors.white70),
    textButtonTheme: _getTextButtonTheme(Colors.teal.shade100),
  );
}
