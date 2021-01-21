import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Client {
  String id;
  String name;

  Client({
    Key key,
    this.id,
    this.name,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
