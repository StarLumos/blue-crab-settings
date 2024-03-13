import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';

class Report {
  DateTime time = DateTime.now();
  List<DataPoint> dataPoints = [];

  List<Device> getDevices() {
    Set<Device> devices = <Device>{};
    for (var dataPoint in dataPoints) {
      for (var device in dataPoint.devices) {
        devices.add(Device(device.device, device.advertisementData));
      }
    }
    return devices.toList();
  }
}

class DataPoint {
  Position location;
  late List<ScanResult> devices;
  DateTime time = DateTime.now();
  DataPoint(this.location, this.devices);
}

class Device {
  BluetoothDevice device;
  AdvertisementData data;
  Device(this.device, this.data);
}
