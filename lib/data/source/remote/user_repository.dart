import 'dart:convert';
import 'dart:io';

import 'package:driver_track/data/models/api_error.dart';
import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/extensions.dart';
import 'package:driver_track/injector.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<User> updateServiceAvailability(bool isAvailable);

  Future<User> updateAirportAvailability(bool isNear);

  Future updateUserLocation(double lat, double lon);

  Future<User> getUserInfo();
}

class UserRepositoryImpl implements UserRepository {
  final String _baseUrl;

  UserRepositoryImpl(this._baseUrl);

  @override
  Future<User> updateServiceAvailability(bool isAvailable) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/drivers/availability",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: json.encode({'available': isAvailable}),
    );
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return User.fromJson(jsonObject);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future<User> updateAirportAvailability(bool isNear) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/drivers/airport_availability",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: json.encode({'available': isNear}),
    );
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return User.fromJson(jsonObject);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future updateUserLocation(double lat, double lon) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/user/location",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: json.encode({
        'latitude': lat,
        'longitude': lon,
        'date': new DateTime.now().dateToString()
      }),
    );
  }

  @override
  Future<User> getUserInfo() async {
    var token = await Injector.instance.getUserToken();
    var response = await http.get("$_baseUrl/profile", headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return User.fromJson(jsonObject);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }
}
