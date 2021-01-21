import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DefaultResponse {
  bool success;
  String message;

  DefaultResponse({
    Key key,
    this.success,
    this.message,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultResponseToJson(this);
}
