import 'package:flutter/material.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/theme/app_colors.dart';

class HomeIndicator extends StatelessWidget {
  const HomeIndicator({super.key, required this.darkMode});

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    final barColor = darkMode ? AppColors.white : AppColors.lightText;

    return SizedBox(
      height: AppLayout.homeIndicatorHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: AppLayout.homeIndicatorBarTop),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppLayout.homeIndicatorBarWidth,
            height: AppLayout.homeIndicatorBarHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(
                  AppLayout.homeIndicatorBarRadius,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
