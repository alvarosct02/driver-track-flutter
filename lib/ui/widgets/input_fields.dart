import 'dart:math';

import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';

class AppTextField extends TextField {
  AppTextField({
    Key key,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscureText = false,
    String hint,
    Icon icon,
    bool readOnly = false,
    int minLines,
    int maxLines = 1,
  }) : super(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    readOnly: readOnly,
    style: AppTextStyles.body,
    minLines: minLines,
    maxLines: max(minLines ?? 1, maxLines),
    decoration: AppInputDecoration(hint),
  );
}

InputDecoration AppInputDecoration(String label, {
  EdgeInsets contentPadding,
  bool showBorders = true,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: AppTextStyles.caption.copyWith(color: AppColors.primaryColor),
    contentPadding: contentPadding ?? const EdgeInsets.all(AppDimens.sizeDefault),
    enabledBorder: !showBorders ? InputBorder.none : OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      borderRadius: AppBorderRadius.small,
    ),
    focusedBorder: !showBorders ? InputBorder.none : OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      borderRadius: AppBorderRadius.small,
    ),
    // icon: icon ?? Opacity(child: Icon(Icons.apps), opacity: 0),
  );
}
