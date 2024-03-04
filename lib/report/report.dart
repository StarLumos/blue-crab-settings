part of 'package:bluetooth_detector/map_view/map_view.dart';

class Report {
  DateTime time = DateTime.now();
  List<DataPoint> dataPoints = [];
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
