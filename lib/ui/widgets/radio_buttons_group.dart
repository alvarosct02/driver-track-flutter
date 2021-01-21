import 'package:flutter/material.dart';
import 'package:driver_track/ui/widgets/labels.dart';

// ignore: must_be_immutable
class RadioButtonsGroup<T> extends StatefulWidget {
  List<T> options;
  void Function(T) listener;
  T current;

  RadioButtonsGroup(this.options, this.listener) {
    if (options.length != 0) {
      this.current = options.first;
    }
  }

  @override
  _RadioButtonsGroupState createState() => _RadioButtonsGroupState();
}

class _RadioButtonsGroupState<T> extends State<RadioButtonsGroup<T>> {
  List<Widget> _radioButtonList() {
    List<Widget> widgetList = [];

    for (var option in widget.options) {
      var radioButton = RadioListTile<T>(
        title: AppText.body(option.toString()),
        value: option,
        groupValue: widget.current,
        onChanged: (T value) {
          setState(() {
            widget.listener?.call(value);
            widget.current = value;
          });
        },
      );

      widgetList.add(radioButton);
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _radioButtonList(),
    );
  }
}
