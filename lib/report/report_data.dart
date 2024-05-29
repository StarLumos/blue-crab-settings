import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/report/datum.dart';

class ReportData {
  /// Time the report is created
  DateTime time = DateTime.now();

  /// Raw data to generate report from
  List<Datum> dataPoints = [];

  /// Generate report based on data from dataPoints
  Report generateReport() {
    Report report = Report();
    Set<Device> devices = _getDevices();

    for (Device device in devices) {
      report[device.device.remoteId] = device;
    }

    for (Datum dataPoint in dataPoints) {
      for (DeviceIdentifier deviceID in dataPoint.devices.map((e) => e.device.remoteId)) {
        report[deviceID]!.dataPoints.add(dataPoint);
      }
    }

    return report;
  }

  /// Get list of devices present in dataPoints
  Set<Device> _getDevices() {
    Set<Device> devices = <Device>{};
    for (Datum dataPoint in dataPoints) {
      for (ScanResult device in dataPoint.devices) {
        devices.add(Device(device.device, device.advertisementData));
      }
    }
    return devices;
  }
}
