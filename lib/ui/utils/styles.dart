import 'package:flutter/material.dart';

class AppColors {
  static const Color green = Color.fromARGB(255, 74, 156, 147);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color yellow = Color.fromARGB(255, 246, 180, 0);
  static const Color red = Color.fromARGB(255, 170, 56, 56);
  static const Color steel = Color.fromARGB(255, 113, 116, 140);

  // static const Color blueGrey = Color.fromARGB(255, 158, 163, 186);
  // static const Color primaryColor = Color.fromARGB(255, 79, 87, 141);
  // static const Color primaryDarkColor = Color.fromARGB(255, 53, 57, 92);
  // static const Color accentColor = yellow;
  // static const Color backgroundColor = Color.fromARGB(255, 250, 250, 250);
  // static const Color transparent = Colors.transparent;

  static const Color blueGrey = Color.fromARGB(255, 158, 163, 186);
  static const Color primaryColor = Color.fromARGB(255, 7, 53, 122);
  static const Color primaryDarkColor = Color.fromARGB(255, 53, 57, 92);
  static const Color accentColor = Color.fromARGB(255, 0, 194, 206);
  static const Color backgroundColor = Color.fromARGB(255, 250, 250, 250);
  static const Color transparent = Colors.transparent;

  static const Color textPrimary = Color.fromARGB(255, 16, 16, 16);
  static const Color textHint = Color.fromARGB(255, 231, 232, 238);
  static const Color textSecondary = Color.fromARGB(153, 66, 72, 116);

  static const Color textDisabled = Color.fromARGB(255, 160, 160, 160);
}

class AppDimens {
  static const double none = 0;

  static const double sizeXXSmall = 2;
  static const double sizeXSmall = 4;
  static const double sizeSmall = 8;
  static const double sizeSmallPlus = 12;
  static const double sizeDefault = 16;
  static const double sizeDefaultPlus = 24;
  static const double sizeLarge = 32;
  static const double sizeLargePlus = 48;
  static const double sizeXLarge = 64;

  static const double textSizeLabelBottomBar = 12;
  static const double textSizeFloatingLabel = 10;
  static const double textSizeCaption = 14;
  static const double textSizeBody = 16;
  static const double textSizeSubtitle = 18;
  static const double textSizeTitle = 20;
  static const double textSizeDisplay1 = 24;
  static const double textSizeDisplay2 = 32;
}

class AppBorderRadius {
  static BorderRadius small = BorderRadius.circular(8);
  static BorderRadius regular = BorderRadius.circular(14);
  static BorderRadius circle = BorderRadius.circular(99);
  static BorderRadius regularOnlyTop = BorderRadius.only(
    topLeft: const Radius.circular(32),
    topRight: const Radius.circular(32),
  );
}

class AppWeight {
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semibold = FontWeight.w700;
  static const FontWeight regular = FontWeight.w400;
}

class AppTextStyles {
  static const TextStyle bottomBar = TextStyle(
      fontSize: AppDimens.textSizeLabelBottomBar,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle caption = TextStyle(
      fontSize: AppDimens.textSizeCaption,
      color: AppColors.textPrimary,
      fontWeight: AppWeight.semibold,
      fontFamily: 'Muli');

  static const TextStyle label = TextStyle(
      fontSize: AppDimens.textSizeCaption,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle body = TextStyle(
      fontSize: AppDimens.textSizeBody,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w400,
      fontFamily: 'Muli');

  static const TextStyle body2 = TextStyle(
      fontSize: AppDimens.textSizeBody,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle display1 = TextStyle(
      fontSize: AppDimens.textSizeDisplay1,
      color: AppColors.textPrimary,
      fontWeight: AppWeight.bold,
      fontFamily: 'Muli');

  static const TextStyle display2 = TextStyle(
      fontSize: AppDimens.textSizeDisplay2,
      color: AppColors.textPrimary,
      fontWeight: AppWeight.bold,
      fontFamily: 'Muli');

  static const TextStyle title = TextStyle(
      fontSize: AppDimens.textSizeTitle,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle subtitle = TextStyle(
      fontSize: AppDimens.textSizeSubtitle,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle storeStyle = TextStyle(
      fontSize: AppDimens.textSizeDisplay1,
      color: AppColors.white,
      letterSpacing: 1.2,
      shadows: [
        Shadow(
          blurRadius: 2.0,
          color: AppColors.primaryDarkColor,
          offset: Offset(2.0, 2.0),
        ),
      ],
      fontWeight: FontWeight.w900,
      fontFamily: 'Muli');

  static const TextStyle hint = TextStyle(
      fontSize: AppDimens.textSizeBody,
      color: AppColors.textHint,
      fontWeight: FontWeight.w400,
      fontFamily: 'Muli');

  static const TextStyle raisedButton = TextStyle(
      fontSize: AppDimens.textSizeBody,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');

  static const TextStyle textButton = TextStyle(
      fontSize: AppDimens.textSizeBody,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Muli');
}
