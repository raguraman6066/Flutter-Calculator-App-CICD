import 'package:flutter/material.dart';

import '../../../../core/constants/app_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key, required this.darkMode, this.time = '9:41'});

  final bool darkMode;
  final String time;

  @override
  Widget build(BuildContext context) {
    final timeColor = darkMode ? AppColors.darkText : AppColors.lightText;

    return SizedBox(
      height: AppLayout.statusBarHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppLayout.statusBarTimeLeft,
          top: AppLayout.statusBarTimeTop,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            time,
            style: AppTypography.statusTime.copyWith(color: timeColor),
          ),
        ),
      ),
    );
  }
}
