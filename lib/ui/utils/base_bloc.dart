import 'dart:async';

import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/base_bloc_events.dart';

abstract class BaseBloc {
  @protected
  final uiController = StreamController<UiEvent>();
  Stream<UiEvent> get uiEventStream => uiController.stream;

  @protected
  final dialogController = StreamController<DialogEvent>();
  Stream<DialogEvent> get dialogEventStream => dialogController.stream;

  @protected
  final navController = StreamController<NavEvent>();
  Stream<NavEvent> get navEventStream => navController.stream;

  void dispose() {
    uiController.close();
    dialogController.close();
    navController.close();
  }
}
