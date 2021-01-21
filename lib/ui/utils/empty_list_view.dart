import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class EmptyListView extends StatelessWidget {
  final String text;

  const EmptyListView(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.sizeDefault,
        vertical: AppDimens.sizeDefault,
      ),
      child: Center(
        child: AppText.subtitle(
          text,
          opacity: 0.6,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}
