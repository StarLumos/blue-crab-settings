import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

typedef Report = Map<DeviceIdentifier, Device?>;

class ReportData {
  /// Time the report is created
  DateTime time = DateTime.now();

  /// Raw data to generate report from
  List<DataPoint> dataPoints = [];

  /// Generate report based on data from dataPoints
  Report generateReport() {
    Report report = Report();
    Set<Device> devices = _getDevices();

    for (Device device in devices) {
      report[device.device.remoteId] = device;
    }

    for (DataPoint dataPoint in dataPoints) {
      for (DeviceIdentifier deviceID in dataPoint.devices.map((e) => e.device.remoteId)) {
        report[deviceID]!.locations.add(LatLng.degree(dataPoint.location.latitude, dataPoint.location.longitude));
      }
    }

    return report;
  }

  /// Get list of devices present in dataPoints
  Set<Device> _getDevices() {
    Set<Device> devices = <Device>{};
    for (DataPoint dataPoint in dataPoints) {
      for (ScanResult device in dataPoint.devices) {
        devices.add(Device(device.device, device.advertisementData));
      }
    }
    return devices;
  }
}

/// Datum used to generate Data
class DataPoint {
  Position location;
  List<ScanResult> devices;
  DateTime time = DateTime.now();
  DataPoint(this.location, this.devices);
}

/// Device data type
///
/// This type is used to pair details of Bluetooth Devices
/// along with metadata that goes along with it
class Device {
  BluetoothDevice device;
  AdvertisementData data;
  Set<LatLng> locations = {};
  Device(this.device, this.data);
}
