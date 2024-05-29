// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      (json['devices'] as List<dynamic>)
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
    )..time = DateTime.parse(json['time'] as String);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'devices': instance.devices,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'time': instance.time.toIso8601String(),
    };
