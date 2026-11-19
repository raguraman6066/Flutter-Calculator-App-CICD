import 'package:flutter/material.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.emphasis,
    this.label,
    this.onPressed,
  });

  final CalculatorEmphasis emphasis;
  final String? label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final fill = AppColors.buttonFill(
      brightness: brightness,
      emphasis: emphasis,
    );
    final labelColor = AppColors.buttonLabel(
      brightness: brightness,
      emphasis: emphasis,
    );

    return SizedBox(
      height: AppLayout.buttonHeight,
      child: GestureDetector(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(AppLayout.buttonRadius),
          ),
          child: Center(
            child: label == null
                ? null
                : Text(
                    label!,
                    style: AppTypography.button.copyWith(color: labelColor),
                  ),
          ),
        ),
      ),
    );
  }
}
