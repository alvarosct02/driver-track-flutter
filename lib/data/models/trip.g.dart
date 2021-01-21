// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) {
  return Trip(
    id: json['id'] as String,
    code: json['code'] as String,
    url: json['url'] as String,
    date: json['date'] as String,
    hour: json['hour'] as String,
    price: (json['price'] as num)?.toDouble(),
    status: json['status'] as int,
    clientName: json['client_name'] as String,
    client: json['client'] == null
        ? null
        : Client.fromJson(json['client'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'url': instance.url,
      'date': instance.date,
      'hour': instance.hour,
      'price': instance.price,
      'status': instance.status,
      'client_name': instance.clientName,
      'client': instance.client,
    };
