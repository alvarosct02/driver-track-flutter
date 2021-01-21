import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/input_fields.dart';
import 'package:driver_track/ui/widgets/toggle_button.dart';

class AppToggleGroup<T> extends StatefulWidget {
  final List<T> itemList;
  final void Function(T) onItemSelected;
  final String label;

  const AppToggleGroup({
    Key key,
    this.itemList, this.label, this.onItemSelected,
  }) : super(key: key);

  @override
  _AppToggleGroupState<T> createState() => _AppToggleGroupState();
}

class _AppToggleGroupState<T> extends State<AppToggleGroup<T>> {

  int selectedPos;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: AppInputDecoration(
        widget.label ?? 'Field Label',
        showBorders: false,
        contentPadding: EdgeInsets.all(AppDimens.none),
      ),
      child: Row(
        children: itemWidgetList(),
      ),
    );
  }

  List<Widget> itemWidgetList() {
    List<Widget> list = [];

    for (int i = 0; i < widget.itemList.length; i++) {
      if (i != 0) list.add(SizedBox(width: AppDimens.sizeDefault));
      list.add(Expanded(
        flex: 1,
        child: AppToggleButton(
          widget.itemList[i].toString(),
          selected: i == selectedPos,
          onToggleChanged: (b) {
            widget.onItemSelected?.call(widget.itemList[i]);
            setSelectedPos(i);
          },
        ),
      ));
    }

    return list;
  }

  void setSelectedPos(int pos) {
    setState(() {
      selectedPos = pos;
    });
  }
}
