// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
    )..time = DateTime.parse(json['time'] as String);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      "\"latitude\"": instance.latitude,
      "\"longitude\"": instance.longitude,
      "\"time\"": "\"${instance.time.toIso8601String()}\"",
    };
