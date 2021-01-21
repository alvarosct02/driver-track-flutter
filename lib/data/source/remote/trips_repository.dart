import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:driver_track/data/models/api_error.dart';
import 'package:driver_track/data/models/trip.dart';
import 'package:driver_track/injector.dart';

abstract class TripsRepository {
  Future<List<Trip>> listTrips();

  Future<Trip> startTrip(String id);

  Future<Trip> endTrip(String id);
}

class TripsRepositoryImpl implements TripsRepository {
  final String _baseUrl;

  TripsRepositoryImpl(this._baseUrl);

  @override
  Future<List<Trip>> listTrips() async {
    var token = await Injector.instance.getUserToken();
    var response = await http.get(
      "$_baseUrl/trips",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      var jsonArray = json.decode(response.body) as List;
      var mapList = jsonArray.map((jsonObject) => Trip.fromJson(jsonObject));
      return mapList.toList();
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future<Trip> startTrip(String id) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/trips/$id/start",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return Trip.fromJson(jsonObject);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future<Trip> endTrip(String id) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/trips/$id/finish",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return Trip.fromJson(jsonObject);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }
}
