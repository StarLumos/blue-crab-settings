import 'dart:ffi';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:latlng/latlng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

/// Datum used to generate Data
@JsonSerializable()
class Datum {
  List<ScanResult> devices;
  double? latitude;
  double? longitude;
  DateTime time = DateTime.now();

  late LatLng? location = (() {
    LatLng? result = null;
    if (latitude != null && longitude != null) {
      result = LatLng.degree(latitude!, longitude!);
    }
    return result;
  })();

  Datum(this.devices, this.latitude, this.longitude);
}
