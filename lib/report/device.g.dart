// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      json['id'] as String,
      json['name'] as String,
      json['platformName'] as String,
      (json['manufacturer'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      "\"id\"": "\"${instance.id}\"",
      "\"name\"": "\"${instance.name}\"",
      "\"platformName\"": "\"${instance.platformName}\"",
      "\"manufacturer\"": instance.manufacturer,
    };
