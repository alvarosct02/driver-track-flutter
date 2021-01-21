import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class AppTextView extends StatelessWidget {
  String label;
  String text;
  double paddingBelow;
  int maxLines;

  AppTextView(
    this.label,
    this.text, {
    this.paddingBelow = AppDimens.sizeDefault,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (text?.isEmpty ?? true) return Container();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.caption(
            label ?? "",
            opacity: 0.6,
          ),
          SizedBox(
            height: AppDimens.sizeXSmall,
          ),
          AppText.body(
            text ?? "",
            textWeight: AppWeight.regular,
            maxLines: maxLines,
          ),
          if (paddingBelow != 0)
            SizedBox(
              height: paddingBelow,
            ),
        ],
      ),
    );
  }
}
