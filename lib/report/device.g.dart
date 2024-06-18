// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      json['id'] as String,
      json['name'] as String,
      json['platformName'] as String,
      (json['manufacturer'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    )
      ..dataPoints = (json['dataPoints'] as List<dynamic>).map((e) => Datum.fromJson(e as Map<String, dynamic>)).toSet()
      ..incidence = (json['incidence'] as num).toInt();

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      "\"id\"": "\"${instance.id}\"",
      "\"name\"": "\"${instance.name}\"",
      "\"platformName\"": "\"${instance.platformName}\"",
      "\"manufacturer\"": instance.manufacturer,
      "\"dataPoints\"": instance.dataPoints.map((x) => x.toJson()).toList(),
      "\"incidence\"": instance.incidence,
    };
