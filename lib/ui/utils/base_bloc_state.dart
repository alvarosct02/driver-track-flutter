import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:driver_track/ui/utils/base_bloc_events.dart';
import 'package:driver_track/ui/utils/dialog_manager.dart';

abstract class BaseBlocState<S extends StatefulWidget, B extends BaseBloc>
    extends State<S> {
  B bloc;

  @override
  void initState() {
    super.initState();

    bloc.uiEventStream.listen((event) {
      handleUiEvent(event);
    });
    bloc.dialogEventStream.listen((event) {
      switch (event.runtimeType) {
        case ShowLoading:
          DialogManager()
              .show(context, message: (event as ShowLoading).message);
          break;
        case HideLoading:
          DialogManager().hide();
          break;
        case ShowAlert:
          DialogManager()
              .showAlert(context, message: (event as ShowAlert).message);
          break;
        default:
          handleDialogEvent(event);
      }
    });
    bloc.navEventStream.listen((event) {
      handleNavigationEvent(event);
    });
  }

  void handleUiEvent(UiEvent event) {}

  void handleDialogEvent(DialogEvent event) {}

  void handleNavigationEvent(NavEvent event){}

  bool isKeyboardOpen() {
    return MediaQuery.of(context).viewInsets.bottom == 0.0;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
