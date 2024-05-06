import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:bluetooth_detector/settings.dart';

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
        report[deviceID]!.dataPoints.add(DeviceDataPoint(dataPoint.time, dataPoint.location));
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
  Position? location;
  List<ScanResult> devices;
  DateTime time = DateTime.now();
  DataPoint(this.location, this.devices);
}

class DeviceDataPoint {
  DateTime time;
  Position? location;
  DeviceDataPoint(this.time, this.location);
}

/// Device data type
///
/// This type is used to pair details of Bluetooth Devices
/// along with metadata that goes along with it
class Device {
  BluetoothDevice device;
  AdvertisementData data;
  Set<DeviceDataPoint> dataPoints = {};
  Device(this.device, this.data);

  late Set<LatLng> locations = (() {
    Set<LatLng> locations = {};
    for (DeviceDataPoint dataPoint in this.dataPoints) {
      if (dataPoint.location == null) continue;
      locations.add(LatLng.degree(dataPoint.location!.latitude, dataPoint.location!.longitude));
    }
    return locations;
  })();

  late int incidence = (() {
    int result = 0;
    List<DeviceDataPoint> dataPoints = this.dataPoints.sorted((a, b) => a.time.compareTo(b.time));
    while (dataPoints.length > 1) {
      DateTime a = dataPoints.elementAt(0).time;
      DateTime b = dataPoints.elementAt(1).time;
      Duration c = b.difference(a);
      result += c > (Settings.scanTime * 2) ? 1 : 0;
      dataPoints.removeAt(0);
    }
    return result;
  })();

  late Set<Area> areas = (() {
    Set<Area> result = {};
    for (LatLng curr in locations) {
      if (result.isEmpty) {
        Area a = {};
        a.add(curr);
        result.add(a);
        continue;
      }
      for (Area area in result) {
        for (LatLng location in area) {
          double distance = Geolocator.distanceBetween(
              curr.latitude.degrees, curr.longitude.degrees, location.latitude.degrees, location.longitude.degrees);
          if (distance <= Settings.distance) {
            area.add(curr);
            break;
          }
        }
      }
    }
    for (Area area1 in result) {
      for (Area area2 in result.difference({area1})) {
        if (area1.intersection(area2).isNotEmpty) {
          area1 = area1.union(area2);
          result.remove(area2);
        }
      }
    }
    return result;
  })();
}

typedef Area = Set<LatLng>;
