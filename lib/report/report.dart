import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:latlng/latlng.dart';
import 'package:bluetooth_detector/report/device.dart';

typedef Report = Map<DeviceIdentifier, Device?>;
typedef Area = Set<LatLng>;
