import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:latlng/latlng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

// Datum(this.location, this.devices);

/// Datum used to generate Data
@JsonSerializable()
class Datum {
  LatLng? location;
  List<ScanResult> devices;
  DateTime time = DateTime.now();

  Datum(this.location, this.devices, this.time);
  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
