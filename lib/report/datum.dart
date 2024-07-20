import 'package:latlng/latlng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

/// Datum used to generate Data
@JsonSerializable()
class Datum {
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

  Datum(this.latitude, this.longitude);
  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
