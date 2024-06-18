// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportData _$ReportDataFromJson(Map<String, dynamic> json) => ReportData()
  ..time = DateTime.parse(json['time'] as String)
  ..data = (json['data'] as List<dynamic>).map((e) => Datum.fromJson(e as Map<String, dynamic>)).toList();

Map<String, dynamic> _$ReportDataToJson(ReportData instance) => <String, dynamic>{
      "\"time\"": "\"${instance.time.toIso8601String()}\"",
      "\"data\"": instance.data.map((x) => x.toJson()).toList(),
    };
