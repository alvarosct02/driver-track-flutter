import 'package:driver_track/data/source/services/auth_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/login/login_screen.dart';
import 'package:driver_track/ui/trips/list/trip_list_screen.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:flutter/material.dart';

class SplashBloc extends BaseBloc {
  final AuthService _userService = Injector.instance.authService;

  void init() async {
    try {
      final user = await _userService.getLoggedUser();
      await Future.delayed(const Duration(seconds: 1));
      if (user != null) {
        NavigatorManager()
            .getKey()
            .currentState
            .pushReplacementNamed(TripListScreen.route);
      } else {
        NavigatorManager()
            .getKey()
            .currentState
            .pushReplacementNamed(LoginScreen.route);
      }
    } catch (err) {
      debugPrint(err);
    }
  }
}
