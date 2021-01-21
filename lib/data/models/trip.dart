import 'package:driver_track/data/models/client.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Trip {
  String id;
  String code;
  String url;
  String date;
  String hour;
  double price;
  int status;
  String clientName;
  Client client;

  Trip({
    Key key,
    this.id,
    this.code,
    this.url,
    this.date,
    this.hour,
    this.price,
    this.status,
    this.clientName,
    this.client,
  });

  TripStatus getTripStatus() {
    return TripStatus.values[status];
  }

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}

enum TripStatus { PENDING, IN_PROGRESS, FINISHED }
