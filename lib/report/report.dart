import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:bluetooth_detector/settings.dart';
import 'package:bluetooth_detector/report/datum.dart';

typedef Report = Map<DeviceIdentifier, Device?>;
typedef Area = Set<LatLng>;

/// Device data type
///
/// This type is used to pair details of Bluetooth Devices
/// along with metadata that goes along with it
class Device {
  BluetoothDevice device;
  AdvertisementData data;
  Set<Datum> dataPoints = {};
  Device(this.device, this.data);

  late Set<LatLng> locations = (() {
    Set<LatLng> locations = {};
    for (Datum dataPoint in this.dataPoints) {
      if (dataPoint.location == null) continue;
      locations.add(dataPoint.location!);
    }
    return locations;
  })();

  late int incidence = (() {
    int result = 0;
    List<Datum> dataPoints = this.dataPoints.sorted((a, b) => a.time.compareTo(b.time));
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
