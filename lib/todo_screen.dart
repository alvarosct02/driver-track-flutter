import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:driver_track/ui/utils/styles.dart';
import 'package:driver_track/ui/widgets/labels.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.sizeDefault,
            horizontal: AppDimens.sizeDefaultPlus,
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                NavigatorManager().getKey().currentState.pop();
              },
              child: AppText.display1(
                'Pendiente',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
