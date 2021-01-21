import 'dart:convert';

import 'package:driver_track/data/models/trip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver_track/data/models/user.dart';

class SessionRepository {
  static final SessionRepository _instance = SessionRepository._internal();

  factory SessionRepository() {
    return _instance;
  }

  SessionRepository._internal();

  SharedPreferences prefs;

//  Not sure if this improve anything
  Future<SharedPreferences> getPrefs() async {
    prefs ??=  await SharedPreferences.getInstance();
    return prefs;
  }

  void saveOnBoardingCompleted() async {
    var prefs = await getPrefs();
    prefs.setBool('onboarding', true);
  }

  Future<bool> isOnBoardingCompleted() async {
    var prefs = await getPrefs();
    return prefs.getBool('onboarding') ?? false;
  }

  void saveUser(User user) async {
    var prefs = await getPrefs();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<User> getUser() async {
    var prefs = await getPrefs();
    String stringValue = prefs.getString('user');
    if (stringValue == null) return null;
    return User.fromJson(jsonDecode(stringValue));
  }

  void saveToken(String token) async {
    var prefs = await getPrefs();
    prefs.setString('token', token);
  }

  Future<String> getToken() async {
    var prefs = await getPrefs();
    return prefs.getString('token');
  }

  // MARKUP: Current Trip


  void saveCurrentTrip(Trip trip) async {

    if (trip == null) {
      removeCurrentTrip();
      return;
    }
    var prefs = await getPrefs();
    prefs.setString('trip', jsonEncode(trip.toJson()));
  }

  Future<Trip> getCurrentTrip() async {
    var prefs = await getPrefs();
    String stringValue = prefs.getString('trip');
    if (stringValue == null) return Trip();
    return Trip.fromJson(jsonDecode(stringValue));
  }

  void removeCurrentTrip() async {
    var prefs = await getPrefs();
    prefs.remove('trip');
  }


  void logout() async {
    var prefs = await getPrefs();
    prefs.remove('user');
    prefs.remove('profile');
    prefs.remove('token');
    prefs.remove('trip');
  }
}
