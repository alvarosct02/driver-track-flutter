import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';

class AppBackground extends BoxDecoration {
  const AppBackground();

  @override
  Color get color => AppColors.backgroundColor;
}

class AppGradientBackground extends BoxDecoration {
  const AppGradientBackground();

  @override
  Gradient get gradient => LinearGradient(
        colors: [
          AppColors.accentColor.withOpacity(0.5),
          AppColors.primaryColor
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.3, 1],
      );
}

class AppCard extends BoxDecoration {
  AppCard()
      : super(
    color: AppColors.white,
    borderRadius: AppBorderRadius.regular,
    boxShadow: [
      BoxShadow(
        color: AppColors.blueGrey.withAlpha(120),
        blurRadius: 2.0,
      )
    ],
  );
}

class AppCardPrimary extends BoxDecoration {
  AppCardPrimary()
      : super(
    color: AppColors.white,
    borderRadius: AppBorderRadius.regular,
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryColor.withAlpha(120),
        blurRadius: 2.0,
      )
    ],
  );
}

class AppFlatCard extends BoxDecoration {
  AppFlatCard()
      : super(
          color: AppColors.white,
          borderRadius: AppBorderRadius.small,
        );
}
