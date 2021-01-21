import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/input_fields.dart';
import 'package:driver_track/ui/widgets/labels.dart';

// ignore: must_be_immutable
class AppDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final String label;
  final Function(T) onItemSelected;

  T _currentSelection;

  AppDropdownButton({Key key, this.items, this.label, this.onItemSelected})
      : super(key: key);

  @override
  _AppDropdownButtonState<T> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    var items = widget.items;
    items ??= [];

    return InputDecorator(
      decoration: AppInputDecoration(
        widget.label,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimens.sizeDefault,
          vertical: AppDimens.sizeXXSmall,
        ),
      ),
      child: Container(
        width: double.maxFinite,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: false,
            child: DropdownButton<T>(
              items: items.map((value) {
                    return DropdownMenuItem<T>(
                      value: value,
                      child: AppText.body(value?.toString() ?? "-"),
                    );
                  })?.toList() ??
                  [],
              onChanged: (T value) {
                widget.onItemSelected?.call(value);
                setState(() {
                  widget._currentSelection = value;
                });
              },
              hint: AppText.body(
                "Seleccionar",
                textColor: AppColors.textDisabled,
              ),
              value: widget._currentSelection,
            ),
          ),
        ),
      ),
    );
  }
}
