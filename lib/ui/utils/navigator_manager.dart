import 'package:flutter/material.dart';

class NavigatorManager {
  static final NavigatorManager _instance = NavigatorManager._internal();

  GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  factory NavigatorManager() {
    return _instance;
  }

  NavigatorManager._internal();

  GlobalKey<NavigatorState> getKey() {
    return _navigatorKey;
  }

}
