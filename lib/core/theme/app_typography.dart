import 'package:flutter/material.dart';

/// Text settings measured on the calculator page.
class AppTypography {
  const AppTypography._();

  static const String workSans = 'Work Sans';
  static const String ibmPlexMono = 'IBM Plex Mono';

  static const TextStyle expression = TextStyle(
    fontFamily: workSans,
    fontWeight: FontWeight.w300,
    fontSize: 40,
    letterSpacing: 0,
  );

  static const TextStyle result = TextStyle(
    fontFamily: workSans,
    fontWeight: FontWeight.w300,
    fontSize: 96,
    height: 96 / 96,
    letterSpacing: 0,
  );

  static const TextStyle button = TextStyle(
    fontFamily: workSans,
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: 0,
  );

  static const TextStyle resizeHint = TextStyle(
    fontFamily: ibmPlexMono,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 24 / 32,
    letterSpacing: 0.15,
  );

  /// Status-bar clock. Figma uses SF Pro Text Semibold; that family is not bundled.
  static const TextStyle statusTime = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20 / 15,
    letterSpacing: -0.5,
  );
}
