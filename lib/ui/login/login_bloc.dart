import 'package:driver_track/data/source/services/auth_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/trips/list/trip_list_screen.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:driver_track/ui/utils/base_bloc_events.dart';
import 'package:driver_track/ui/utils/dialog_manager.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:flutter/material.dart';

class LoginBloc extends BaseBloc {
  final AuthService _authService = Injector.instance.authService;

  void login(String username, String password) async {
    dialogController.add(ShowLoading("Cargando"));
    try {
      var user = await _authService.login(username, password);
      _authService.saveLoggedUser(user);

      sendFcmToken();
    } on Exception catch (err) {
      dialogController.add(HideLoading());
      dialogController.add(ShowAlert(err.toString()));
      debugPrint(err.toString());
    }
  }

  void sendFcmToken() async {
    try {
      var token = "TOKEEEEN";

      var result = await _authService.updateFcm(token);
      debugPrint(token);
      debugPrint(result);

      DialogManager().hide();
      NavigatorManager()
          .getKey()
          .currentState
          .pushReplacementNamed(TripListScreen.route);
    } on Exception catch (err) {
      dialogController.add(HideLoading());
      dialogController.add(ShowAlert(err.toString()));
      debugPrint(err.toString());
    }
  }

  void openForgotPassword() {
    navController.add(NavToSignUp());
  }
}

// UI EVENTS
