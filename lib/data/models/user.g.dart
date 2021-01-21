// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    companyName: json['company_name'] as String,
    carPlate: json['car_plate'] as String,
    carBrand: json['car_brand'] as String,
    carModel: json['car_model'] as String,
    status: json['status'] as int,
    atAirport: json['at_airport'] as bool,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'company_name': instance.companyName,
      'car_plate': instance.carPlate,
      'car_brand': instance.carBrand,
      'car_model': instance.carModel,
      'status': instance.status,
      'at_airport': instance.atAirport,
      'token': instance.token,
    };
