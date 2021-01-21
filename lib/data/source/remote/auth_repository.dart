import 'dart:convert';
import 'dart:io';

import 'package:driver_track/data/models/api_error.dart';
import 'package:driver_track/data/models/user.dart';
import 'package:driver_track/injector.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<User> login(String username, String password);

  Future updateFcmToken(String fcmToken);
}

class AuthRepositoryImpl implements AuthRepository {
  final String _baseUrl;

  AuthRepositoryImpl(this._baseUrl);

  @override
  Future updateFcmToken(String fcmToken) async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/update_fcm",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: json.encode({'token': fcmToken}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return;
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future<User> login(String username, String password) async {
    var response = await http.post(
      "$_baseUrl/login",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({'email': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return User.fromJson(body);
    } else {
      var error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.message);
    }
  }

  @override
  Future logout() async {
    var token = await Injector.instance.getUserToken();
    var response = await http.post(
      "$_baseUrl/logout",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
  }
}
