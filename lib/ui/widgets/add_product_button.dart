import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/buttons.dart';
import 'package:driver_track/ui/widgets/labels.dart';

typedef void OnProductCountChange(int count);

// ignore: must_be_immutable
class AddProductButton extends StatefulWidget {
  int currentCount;
  OnProductCountChange listener;
  AddProductButton(this.currentCount, this.listener);

  @override
  _AddProductButtonState createState() => _AddProductButtonState();
}

class _AddProductButtonState extends State<AddProductButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Stack(
      //   children: <Widget>[
      //     _addFirst(),
      //     _quantyLayout(),
      //   ],
      // ),
      child: widget.currentCount == 0 ? _addFirst() : _quantyLayout(),
    );
  }

  Widget _addFirst() {
    return Center(
      child: AppRaisedButton(
        "Agregar",
        paddingVertical: AppDimens.sizeXSmall,
        onClick: _incrementCount,
      ),
    );
  }

  Widget _quantyLayout() {
    return Container(
      child: Row(
        children: <Widget>[
          AppRaisedButton(
            "-",
            paddingVertical: AppDimens.sizeXSmall,
            onClick: _decrementCount,
          ),
          Container(
            width: 30,
            child: Center(
              child: AppLabel(
                widget.currentCount.toString(),
                textStyle: AppTextStyles.body2,
              ),
            ),
          ),
          AppRaisedButton(
            "+",
            paddingVertical: AppDimens.sizeXSmall,
            onClick: _incrementCount,
          ),
        ],
      ),
    );
  }

  void _incrementCount() {
    setState(() {
      widget.currentCount += 1;
      widget.listener(widget.currentCount);
    });
  }

  void _decrementCount() {
    setState(() {
      widget.currentCount -= 1;
      widget.listener(widget.currentCount);
    });

  }
}
