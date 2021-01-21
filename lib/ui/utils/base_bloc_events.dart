// Base

import 'package:driver_track/todo_screen.dart';
import 'package:flutter/material.dart';

abstract class UiEvent {}

abstract class DialogEvent {}

abstract class NavEvent {
  Widget screenRoute = TodoScreen();

  MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => screenRoute,
    );
  }
}

// Dialog Events

class ShowLoading extends DialogEvent {
  String message;

  ShowLoading(this.message);
}

class HideLoading extends DialogEvent {}

class ShowAlert extends DialogEvent {
  String message;

  ShowAlert(this.message);
}

// Dialog Events

class DialogValidationEvent extends DialogEvent {
  String message;

  DialogValidationEvent(this.message);
}

// Navigation Events

class NavBack extends NavEvent {}

class NavToLogin extends NavEvent {}

class NavToOnBoarding extends NavEvent {}

class NavToSignUp extends NavEvent {}

class NavToMain extends NavEvent {}

class NavToProfileSelection extends NavEvent {}

class NavToCart extends NavEvent {}

class NavToOrderList extends NavEvent {}

class NavToFavoriteStores extends NavEvent {}

class NavToAllStores extends NavEvent {}

class NavToAddressList extends NavEvent {}

class NavToCompleteCheckout extends NavEvent {}
