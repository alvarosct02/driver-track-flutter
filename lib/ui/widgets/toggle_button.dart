import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class AppToggleButton<T> extends StatefulWidget {
  final T obj;
  final void Function(bool) onToggleChanged;
  bool selected = false;

  AppToggleButton(
    this.obj, {
    this.onToggleChanged,
    this.selected,
  });

  @override
  _AppToggleButtonState<T> createState() => _AppToggleButtonState();
}

class _AppToggleButtonState<T> extends State<AppToggleButton<T>> {
  @override
  Widget build(BuildContext context) {
    var isSelected = widget.selected;
    var label = widget.obj.toString();

    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                widget.selected = !widget.selected;
                widget.onToggleChanged?.call(widget.selected);
              });
            },
            // splashColor: Colors.white.withAlpha(160),
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.sizeDefault,
              vertical: AppDimens.sizeDefault,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.small,
                side: BorderSide(
                  width: isSelected ? 3 : 1.5,
                  color: AppColors.primaryColor,
                )),
            child: AppText.caption(
              label,
              textAlign: TextAlign.center,
              textColor: AppColors.primaryColor,
              textWeight: isSelected ? AppWeight.bold : AppWeight.regular,
            ),
          ),
        ),
        if (widget.selected)
          Align(
            alignment: const Alignment(1.0, 0.0),
            child: SizedBox(
              width: 0.0,
              height: 0.0,
              child: OverflowBox(
                minWidth: 0.0,
                maxWidth: AppDimens.sizeLarge,
                minHeight: 0.0,
                maxHeight: AppDimens.sizeLarge,
                child: Container(
                  padding: EdgeInsets.all(AppDimens.sizeXSmall),
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: AppDimens.sizeDefault,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
