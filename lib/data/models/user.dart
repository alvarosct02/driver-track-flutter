import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  int id;
  String firstName;
  String lastName;
  String email;
  // @JsonKey(name: "company_name")
  String companyName;
  String carPlate;
  String carBrand;
  String carModel;
  int status;
  bool atAirport;
  String token;

  User({
    Key key,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.companyName,
    this.carPlate,
    this.carBrand,
    this.carModel,
    this.status,
    this.atAirport,
    this.token,
  });

  bool isAvailable() {
    return this.status != UserAvailability.UNAVAILABLE.index;
  }

  bool isBusy() {
    return this.status == UserAvailability.BUSY.index;
  }

  bool isAtAirport() {
    return this.atAirport == true;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String getFullName() {
    return "$firstName $lastName";
  }
}

enum UserAvailability { UNAVAILABLE, BUSY, AVAILABLE }
