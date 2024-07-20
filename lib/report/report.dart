import 'package:latlng/latlng.dart';
import 'package:bluetooth_detector/report/device.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

typedef Area = Set<LatLng>;

@JsonSerializable()
class Report {
  DateTime time = DateTime.now();
  Map<String, Device?> report;
  Report(this.report);
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
