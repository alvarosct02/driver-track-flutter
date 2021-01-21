import 'package:json_annotation/json_annotation.dart';
part 'api_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiError {
  
  String message;
  String description;
  int code;

  ApiError(this.message, this.description, this.code);

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

}