import 'package:flutter/material.dart';

/// Paint styles from the Figma file. There are no color variables.
class AppColors {
  const AppColors._();

  static const Color lightBackground = Color(0xFFF1F2F3);
  static const Color lightText = Color(0xFF000000);
  static const Color lightButtonLow = Color(0xFFFFFFFF);
  static const Color lightButtonMedium = Color(0xFFD2D3DA);
  static const Color lightButtonHigh = Color(0xFF4B5EFC);

  static const Color darkBackground = Color(0xFF17171C);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkButtonLow = Color(0xFF2E2F38);
  static const Color darkButtonMedium = Color(0xFF4E505F);
  static const Color darkButtonHigh = Color(0xFF4B5EFC);

  static const Color white = Color(0xFFFFFFFF);

  static Color buttonFill({
    required Brightness brightness,
    required CalculatorEmphasis emphasis,
  }) {
    final isLight = brightness == Brightness.light;
    return switch (emphasis) {
      CalculatorEmphasis.low => isLight ? lightButtonLow : darkButtonLow,
      CalculatorEmphasis.medium =>
        isLight ? lightButtonMedium : darkButtonMedium,
      CalculatorEmphasis.high => isLight ? lightButtonHigh : darkButtonHigh,
    };
  }

  static Color buttonLabel({
    required Brightness brightness,
    required CalculatorEmphasis emphasis,
  }) {
    if (emphasis == CalculatorEmphasis.high) {
      return white;
    }
    return brightness == Brightness.light ? lightText : darkText;
  }
}

enum CalculatorEmphasis { low, medium, high }
