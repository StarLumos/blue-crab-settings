import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/report/datum.dart';
import 'package:bluetooth_detector/report/device.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_data.g.dart';

@JsonSerializable()
class ReportData {
  /// Time the report is created
  DateTime time = DateTime.now();

  /// Raw data to generate report from
  List<Datum> data = [];

  ReportData() {}

  /// Generate report based on data from dataPoints
  Report generateReport() {
    Report report = Report({});
    Set<Device> devices = _getDevices();

    for (Device device in devices) {
      report.report[device.id] = device;
    }

    for (Datum dataPoint in data) {
      for (String deviceID in dataPoint.devices.map((e) => e.id)) {
        report.report[deviceID]!.dataPoints.add(dataPoint);
      }
    }

    return report;
  }

  /// Get list of devices present in dataPoints
  Set<Device> _getDevices() {
    Set<Device> devices = <Device>{};
    for (Datum datum in data) {
      for (Device device in datum.devices) {
        devices.add(device);
      }
    }
    return devices;
  }

  factory ReportData.fromJson(Map<String, dynamic> json) => _$ReportDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReportDataToJson(this);
}
