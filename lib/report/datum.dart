import 'package:latlng/latlng.dart';
import 'package:bluetooth_detector/report/device.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

/// Datum used to generate Data
@JsonSerializable()
class Datum {
  List<Device> devices;
  double? latitude;
  double? longitude;
  DateTime time = DateTime.now();

  LatLng? location() {
    LatLng? result = null;
    if (latitude != null && longitude != null) {
      result = LatLng.degree(latitude!, longitude!);
    }
    return result;
  }

  Datum(this.devices, this.latitude, this.longitude);
}
