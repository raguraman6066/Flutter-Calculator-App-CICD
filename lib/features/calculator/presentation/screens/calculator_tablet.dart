import 'package:flutter/material.dart';

import '../../logic/calculator_controller.dart';
import '../widgets/calculator_view.dart';

class CalculatorTablet extends StatelessWidget {
  const CalculatorTablet({
    super.key,
    required this.controller,
    required this.onThemeChanged,
  });

  final CalculatorController controller;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    return CalculatorView(
      controller: controller,
      light: light,
      showStatusBar: false,
      onThemeChanged: onThemeChanged,
    );
  }
}
