import 'dart:async';

import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/source/services/trips_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class TripDetailBloc extends BaseBloc {
  Trip trip;
  final TripsService _tripsService = Injector.instance.tripsService;

  TripDetailBloc(this.trip);

  final tripStatus = StreamController<TripStatus>();


  void endTrip() async {
//    dialogController.add(ShowLoading("Cargando"));
    try {
      trip = await _tripsService.endTrip(trip.id);
      tripStatus.add(trip.getTripStatus());
      // payment.add(dashBoardInfo.payment);
//      dialogController.add(HideLoading());
    } catch (err) {
//      dialogController.add(HideLoading());
//      dialogController.add(ShowAlert(err.toString()));
//      debugPrint(err.toString());
    }
  }

  Future startTrip() async {
//    dialogController.add(ShowLoading("Cargando"));
    try {
      trip = await _tripsService.startTrip(trip.id);
      tripStatus.add(trip.getTripStatus());
      // payment.add(dashBoardInfo.payment);
//      dialogController.add(HideLoading());
    } catch (err) {
//      dialogController.add(HideLoading());
//      dialogController.add(ShowAlert(err.toString()));
     debugPrint(err.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

}

// UI EVENTS
