import 'package:flutter/material.dart';

import 'core/constants/app_layout.dart';
import 'core/theme/app_theme.dart';
import 'features/calculator/logic/calculator_controller.dart';
import 'features/calculator/presentation/screens/calculator_dark.dart';
import 'features/calculator/presentation/screens/calculator_light.dart';
import 'features/calculator/presentation/screens/calculator_tablet.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final CalculatorController _controller = CalculatorController();
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setLight(bool light) {
    setState(() {
      _themeMode = light ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: CalculatorShell(controller: _controller, onThemeChanged: _setLight),
    );
  }
}

class CalculatorShell extends StatelessWidget {
  const CalculatorShell({
    super.key,
    required this.controller,
    required this.onThemeChanged,
  });

  final CalculatorController controller;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppLayout.tabletWidth) {
          return CalculatorTablet(
            controller: controller,
            onThemeChanged: onThemeChanged,
          );
        }
        final isDark = Theme.of(context).brightness == Brightness.dark;
        if (isDark) {
          return CalculatorDark(
            controller: controller,
            onThemeChanged: onThemeChanged,
          );
        }
        return CalculatorLight(
          controller: controller,
          onThemeChanged: onThemeChanged,
        );
      },
    );
  }
}
