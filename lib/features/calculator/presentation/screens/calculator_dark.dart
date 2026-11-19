import 'package:flutter/material.dart';

import '../../logic/calculator_controller.dart';
import '../widgets/calculator_view.dart';

class CalculatorDark extends StatelessWidget {
  const CalculatorDark({
    super.key,
    required this.controller,
    required this.onThemeChanged,
  });

  final CalculatorController controller;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return CalculatorView(
      controller: controller,
      light: false,
      showStatusBar: true,
      onThemeChanged: onThemeChanged,
    );
  }
}
