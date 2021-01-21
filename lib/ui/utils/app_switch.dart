import 'dart:async';

import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatefulWidget {
  bool initialState;
  final String label;
  final String valueWhenEnable;
  final String valueWhenDisable;
  final void Function(bool) onChangedListener;
  StreamController _forceDisable = StreamController<bool>();

  AppSwitch(
      {Key key,
      this.initialState,
      this.label,
      this.valueWhenEnable,
      this.valueWhenDisable,
      this.onChangedListener})
      : super(key: key);

  Future forceDisable() async{
    _forceDisable.add(true);
  }



  @override
  _AppSwitchState createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool isEnabled;

  Color activeColor = Color(0xFFE20018);

  @override
  void initState() {
    isEnabled = widget.initialState;
    widget._forceDisable.stream.listen((event) {
      onChanged(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isEnabled =  widget.initialState;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 160,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.label.isNotEmpty) AppText.caption(
                  widget.label,
                  textAlign: TextAlign.center,
                  textWeight: AppWeight.regular,
                ),
                AppText.subtitle(
                  isEnabled ? widget.valueWhenEnable : widget.valueWhenDisable,
                  textAlign: TextAlign.center,
                  textColor: isEnabled ? activeColor: AppColors.textPrimary,
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }

  void onChanged(bool value) {
    setState(() {
      widget.initialState = value;
      isEnabled = value;
      widget.onChangedListener(value);
    });
  }
}
