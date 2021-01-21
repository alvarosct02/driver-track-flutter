import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/background.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class AppRadioGroup<T> extends StatefulWidget {
  final List<T> itemList;
  final void Function(T) onItemSelected;
  final String label;

  const AppRadioGroup({
    Key key,
    this.itemList,
    this.label,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _AppRadioGroupState<T> createState() => _AppRadioGroupState();
}

class _AppRadioGroupState<T> extends State<AppRadioGroup<T>> {
  int selectedPos;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: itemWidgetList(),
    );
  }

  List<Widget> itemWidgetList() {
    List<Widget> list = [];

    for (int i = 0; i < widget.itemList.length; i++) {
      if (i != 0) list.add(SizedBox(height: AppDimens.sizeDefault));
      list.add(AppRadioButton(
        widget.itemList[i].toString(),
        selected: i == selectedPos,
        onRadioChanged: (b) {
          widget.onItemSelected?.call(widget.itemList[i]);
          setSelectedPos(i);
        },
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

// -----------------------------------------------------------------------------


class AppRadioButton<T> extends StatelessWidget {

  static const double CIRCLE_SIZE = 30;

  final T obj;
  final void Function(bool) onRadioChanged;
  final bool selected;

  AppRadioButton(
      this.obj, {
        this.onRadioChanged,
        this.selected = false,
      });

  @override
  Widget build(BuildContext context) {
    var isSelected = selected;
    var label = obj.toString();
    var outerCircleWidth = isSelected ? 2.5 : 1.5;

    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
            borderRadius: AppBorderRadius.small,
          ),
          child: RawMaterialButton(
            onPressed: () {
              onRadioChanged?.call(selected);
            },
            // splashColor: Colors.white.withAlpha(160),
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.sizeDefault,
              vertical: AppDimens.sizeDefault,
            ),
            // shape: RoundedRectangleBorder(
            //     borderRadius: AppBorderRadius.small,
            //     side: BorderSide(
            //       width: isSelected ? 3 : 1.5,
            //       color: AppColors.primaryColor,
            //     )),
            child: Row(
              children: <Widget>[
                Container(
                  width: CIRCLE_SIZE,
                  height: CIRCLE_SIZE,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: outerCircleWidth),
                    borderRadius: AppBorderRadius.circle,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(AppDimens.sizeXSmall),
                    decoration: !isSelected? null: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor, width: outerCircleWidth),
                      borderRadius: AppBorderRadius.circle,
                    ),
                  ),
                ),
                SizedBox(width: AppDimens.sizeDefault),
                AppText.subtitle(
                  label,
                  textAlign: TextAlign.center,
                  textColor: AppColors.textPrimary,
                  textWeight: isSelected ? AppWeight.bold : AppWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
