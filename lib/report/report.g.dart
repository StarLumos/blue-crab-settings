// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      (json['report'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, e == null ? null : Device.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'report': instance.report,
    };
