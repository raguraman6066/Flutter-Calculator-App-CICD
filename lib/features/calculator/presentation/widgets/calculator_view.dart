import 'package:flutter/material.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../logic/calculator_controller.dart';
import 'calculator_button.dart';
import 'home_indicator.dart';
import 'status_bar.dart';
import 'theme_toggle.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({
    super.key,
    required this.controller,
    required this.light,
    required this.showStatusBar,
    required this.onThemeChanged,
  });

  final CalculatorController controller;
  final bool light;
  final bool showStatusBar;
  final ValueChanged<bool> onThemeChanged;

  static const _keys = <List<_CalcKey>>[
    [
      _CalcKey('C', CalculatorEmphasis.medium),
      _CalcKey('±', CalculatorEmphasis.medium),
      _CalcKey('%', CalculatorEmphasis.medium),
      _CalcKey('÷', CalculatorEmphasis.high),
    ],
    [
      _CalcKey('7', CalculatorEmphasis.low),
      _CalcKey('8', CalculatorEmphasis.low),
      _CalcKey('9', CalculatorEmphasis.low),
      _CalcKey('×', CalculatorEmphasis.high),
    ],
    [
      _CalcKey('4', CalculatorEmphasis.low),
      _CalcKey('5', CalculatorEmphasis.low),
      _CalcKey('6', CalculatorEmphasis.low),
      _CalcKey('−', CalculatorEmphasis.high),
    ],
    [
      _CalcKey('1', CalculatorEmphasis.low),
      _CalcKey('2', CalculatorEmphasis.low),
      _CalcKey('3', CalculatorEmphasis.low),
      _CalcKey('+', CalculatorEmphasis.high),
    ],
    [
      _CalcKey('.', CalculatorEmphasis.low),
      _CalcKey('0', CalculatorEmphasis.low),
      _CalcKey('⌫', CalculatorEmphasis.medium),
      _CalcKey('=', CalculatorEmphasis.high),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = light ? AppColors.lightText : AppColors.darkText;
    final background = light
        ? AppColors.lightBackground
        : AppColors.darkBackground;

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          if (showStatusBar) StatusBar(darkMode: !light),
          SizedBox(
            height: showStatusBar
                ? AppLayout.statusToToggle
                : AppLayout.toggleTop,
          ),
          Center(
            child: ThemeToggle(light: light, onChanged: onThemeChanged),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppLayout.contentInset,
            ),
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return Column(
                  children: [
                    _DisplayLine(
                      height: AppLayout.expressionHeight,
                      text: controller.expression,
                      style: AppTypography.expression.copyWith(
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: AppLayout.rowGap),
                    _DisplayLine(
                      height: AppLayout.resultHeight,
                      text: controller.result,
                      style: AppTypography.result.copyWith(color: textColor),
                    ),
                    const SizedBox(height: AppLayout.rowGap),
                    for (var row = 0; row < _keys.length; row++) ...[
                      if (row > 0) const SizedBox(height: AppLayout.rowGap),
                      Row(
                        children: [
                          for (
                            var column = 0;
                            column < _keys[row].length;
                            column++
                          ) ...[
                            if (column > 0)
                              const SizedBox(width: AppLayout.rowGap),
                            Expanded(
                              child: CalculatorButton(
                                emphasis: _keys[row][column].emphasis,
                                label: _keys[row][column].label,
                                onPressed: () =>
                                    controller.press(_keys[row][column].label),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: AppLayout.contentAboveIndicator),
          HomeIndicator(darkMode: !light),
        ],
      ),
    );
  }
}

class _DisplayLine extends StatelessWidget {
  const _DisplayLine({
    required this.height,
    required this.text,
    required this.style,
  });

  final double height;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Text(text.isEmpty ? ' ' : text, style: style),
      ),
    );
  }
}

class _CalcKey {
  const _CalcKey(this.label, this.emphasis);

  final String label;
  final CalculatorEmphasis emphasis;
}
