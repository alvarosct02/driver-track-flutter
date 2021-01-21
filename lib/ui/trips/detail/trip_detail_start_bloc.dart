import 'dart:async';

import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/data/source/services/trips_service.dart';
import 'package:driver_track/injector.dart';
import 'package:driver_track/ui/utils/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class TripDetailStartBloc extends BaseBloc {
  final Trip trip;
  final TripsService _tripsService = Injector.instance.tripsService;

  TripDetailStartBloc(this.trip);

  StreamController validationError = StreamController<bool>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> validateManualCode(String code) async {
    if (code.toUpperCase() == trip.code.toUpperCase()) {
      // await startTrip();
      validationError.add(false);
      return true;
    } else {
      showErrorAndThenVanish();
      return false;
    }
  }

  Future<bool> validateQRCode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.QR);

      if (barcodeScanRes == trip.url) {
        // await startTrip();
        validationError.add(false);
        return true;
      } else {
        showErrorAndThenVanish();
        return false;
      }

    }  on Exception catch (err) {
      debugPrint(err.toString());
      return false;
    }

  }

  void showErrorAndThenVanish(){
    validationError.add(true);
    debugPrint('Code does NOT match');
    Future.delayed(const Duration(seconds: 5), () {
      validationError.add(false);
    });
  }

}

