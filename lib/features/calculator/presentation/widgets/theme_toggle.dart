import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/theme/app_colors.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, required this.light, required this.onChanged});

  final bool light;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final track = light ? AppColors.white : AppColors.darkButtonLow;
    final knob = light
        ? AppColors.lightButtonMedium
        : AppColors.darkButtonMedium;
    final iconLeft = light
        ? AppLayout.toggleIconLeftLight
        : AppLayout.toggleIconLeftDark;
    final knobLeft = light
        ? AppLayout.toggleKnobLeftLight
        : AppLayout.toggleInset;

    return GestureDetector(
      onTap: () => onChanged(!light),
      child: SizedBox(
        width: AppLayout.toggleWidth,
        height: AppLayout.toggleHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppLayout.toggleRadius),
          child: DecoratedBox(
            decoration: BoxDecoration(color: track),
            child: Stack(
              children: [
                Positioned(
                  left: iconLeft,
                  top: AppLayout.toggleInset,
                  width: AppLayout.toggleIconSize,
                  height: AppLayout.toggleIconSize,
                  child: SvgPicture.asset(
                    light ? 'assets/icons/sun.svg' : 'assets/icons/moon.svg',
                  ),
                ),
                Positioned(
                  left: knobLeft,
                  top: AppLayout.toggleInset,
                  width: AppLayout.toggleKnobSize,
                  height: AppLayout.toggleKnobSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: knob,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
