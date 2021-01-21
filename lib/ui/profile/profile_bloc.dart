import 'dart:async';

import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/data/source/services/auth_service.dart';
import 'package:driver_track/data/source/services/user_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/login/login_screen.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:flutter/cupertino.dart';

class ProfileBloc extends BaseBloc {
  final UserService _userService = Injector.instance.userService;
  final AuthService _authService = Injector.instance.authService;

  ProfileBloc() {
    getUserInfo();
  }

  final userStream = StreamController<User>();

  void getUserInfo() async {
//    dialogController.add(ShowLoading("Cargando"));
    try {
      var user = await _userService.getUserInfo();
      userStream.add(user);
      // payment.add(dashBoardInfo.payment);
//      dialogController.add(HideLoading());
    } catch (err) {
//      dialogController.add(HideLoading());
//      dialogController.add(ShowAlert(err.toString()));
//      debugPrint(err.toString());
    }
  }

  void logout() async {
    _authService.logout();
    NavigatorManager().getKey().currentState.pushNamedAndRemoveUntil(
        LoginScreen.route, (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    userStream.close();
    super.dispose();
  }
}

// UI EVENTS
