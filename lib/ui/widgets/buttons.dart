import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class AppRaisedButton extends RawMaterialButton {
  AppRaisedButton(
    String label, {
    Key key,
    Function onClick,
    Color fillColor = AppColors.primaryColor,
    Color textColor = AppColors.white,
    double paddingVertical = AppDimens.sizeDefault,
    double paddingHorizontal = AppDimens.sizeDefault,
  }) : super(
          onPressed: onClick,
          fillColor: fillColor,
          splashColor: Colors.white.withAlpha(160),
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          child: AppText.subtitle(
            label,
            textAlign: TextAlign.center,
            textColor: textColor,
            textWeight: AppWeight.bold,
          ),
        );

  @override
  BoxConstraints get constraints => super.constraints.copyWith(
        minWidth: 0,
        minHeight: 0,
      );
}

class AppBorderButton extends RawMaterialButton {
  AppBorderButton(
    String label, {
    Key key,
    Function onClick,
    Color color = AppColors.primaryColor,
    Color fillColor,
    double radius,
    Widget customChild,
    double paddingVertical = AppDimens.sizeDefault,
    double paddingHorizontal = AppDimens.sizeDefault,
  }) : super(
          onPressed: onClick,
          splashColor: Colors.white.withAlpha(160),
          fillColor: fillColor,
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 80.0),
              side: BorderSide(
                width: 1,
                color: color,
              )),
          child: customChild ??
              AppText.subtitle(
                label,
                textAlign: TextAlign.center,
                textColor: color,
                textWeight: AppWeight.bold,
              ),
        );

  @override
  BoxConstraints get constraints => super.constraints.copyWith(
        minWidth: 0,
        minHeight: 0,
      );
}

class AppTextButton extends RawMaterialButton {
  AppTextButton(
    String label, {
    Key key,
    FontWeight fontWeight,
    Function onClick,
    Color color = AppColors.primaryColor,
    double paddingVertical = AppDimens.sizeDefault,
    double paddingHorizontal = AppDimens.sizeDefault,
  }) : super(
          onPressed: onClick,
          splashColor: Colors.white.withAlpha(160),
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: AppText.body(
            label,
            textAlign: TextAlign.center,
            textWeight: fontWeight ?? AppWeight.semibold,
            textColor: color,
          ),
        );

  @override
  BoxConstraints get constraints => super.constraints.copyWith(
        minWidth: 0,
        minHeight: 0,
      );
}

class AppBackButton extends StatelessWidget {
  final void Function() onClick;
  final bool isLight;

  AppBackButton({this.onClick, this.isLight = false});

  @override
  Widget build(BuildContext context) {
    final bgColor = isLight
        ? AppColors.white.withOpacity(0.5)
        : AppColors.textDisabled.withOpacity(0.1);

    return InkWell(
      borderRadius: AppBorderRadius.circle,
      child: Container(
        padding: EdgeInsets.all(AppDimens.sizeXXSmall),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.circle,
          color: bgColor,
        ),
        child: Icon(
          Icons.chevron_left,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onClick ?? defaultOnClick,
    );
  }

  void defaultOnClick() {
    NavigatorManager().getKey().currentState.pop();
  }
}
