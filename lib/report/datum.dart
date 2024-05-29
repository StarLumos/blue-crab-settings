import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:latlng/latlng.dart';

/// Datum used to generate Data
class Datum {
  LatLng? location;
  List<ScanResult> devices;
  DateTime time = DateTime.now();

  Datum(this.location, this.devices);
}
