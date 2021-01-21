import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class TopBarDetail extends StatelessWidget {
  final String title;
  final Widget rightItem;

  const TopBarDetail({Key key, this.title = "Title", this.rightItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppDimens.sizeLarge),
      padding: EdgeInsets.symmetric(horizontal: AppDimens.sizeDefault),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: AppText.title(
              title,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.sizeDefault),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(),
            ),
          ),
          if (rightItem != null) Align(
            alignment: Alignment.centerRight,
            child: rightItem,
          ),
        ],
      ),
    );
  }
}
