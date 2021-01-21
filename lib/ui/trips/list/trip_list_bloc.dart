import 'dart:async';

import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/data/source/services/auth_service.dart';
import 'package:driver_track/data/source/services/trips_service.dart';
import 'package:driver_track/data/source/services/user_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/trips/detail/trip_detail_screen.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:driver_track/ui/utils/navigator_manager.dart';
import 'package:flutter/material.dart';

class TripListBloc extends BaseBloc {
  final TripsService _tripsService = Injector.instance.tripsService;
  final UserService _userService = Injector.instance.userService;

  List<Trip> tripList = [];
  User user = null;

  final trips = StreamController<List<Trip>>();
  final userStream = StreamController<User>();

//  final past = StreamController<List<Payment>>.broadcast();

  TripListBloc() {
    getUserInfo();
    getTrips();
  }

  void getTrips() async {
//    dialogController.add(ShowLoading("Cargando"));
    try {
      tripList = await _tripsService.listTrips();
      trips.add(tripList);
      // payment.add(dashBoardInfo.payment);
//      dialogController.add(HideLoading());
    } catch (err) {
      print(err.toString());
//      dialogController.add(HideLoading());
//      dialogController.add(ShowAlert(err.toString()));
//      debugPrint(err.toString());
    }
  }

  void getUserInfo() async {
//    dialogController.add(ShowLoading("Cargando"));
    try {
      user = await _userService.getUserInfo();
      userStream.add(user);
      // payment.add(dashBoardInfo.payment);
//      dialogController.add(HideLoading());
    } catch (err) {
      print(err.toString());
//      dialogController.add(HideLoading());
//      dialogController.add(ShowAlert(err.toString()));
//      debugPrint(err.toString());
    }
  }

  void openTripDetail(Trip obj) async {
    var result = await NavigatorManager().getKey().currentState.push(MaterialPageRoute(
          builder: (context) => TripDetailScreen(trip: obj),
        ));
    getUserInfo();
    if (result is Trip) {
      tripList.firstWhere((obj) => obj.id == result.id).status = result.status;
      trips.add(tripList);
    }
  }

  @override
  void dispose() {
    super.dispose();
    trips.close();
  }

  void changeUserAvailability(bool value) async {
    user = await _userService.updateServiceAvailability(value);
    userStream.add(user);
  }

  void changeAirportAvailability(bool value) async {
    user = await _userService.updateAirportAvailability(value);
    userStream.add(user);
  }

  void forceDisableAtAirport() {
    if (user == null) return;
    user.atAirport = false;
    userStream.add(user);
  }

}

// UI EVENTS
