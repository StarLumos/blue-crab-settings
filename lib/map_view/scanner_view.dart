import 'dart:async';

import 'package:bluetooth_detector/map_view/map_functions.dart';
import 'package:bluetooth_detector/map_view/map_view.dart';
import 'package:bluetooth_detector/map_view/scanner.dart';
import 'package:bluetooth_detector/report_view/report_view.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:bluetooth_detector/report/report.dart';

part 'package:bluetooth_detector/map_view/buttons.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  ScannerViewState createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  Scanner scanner = Scanner();
  Position? location;
  late StreamSubscription<Position> positionStream;
  Offset? dragStart;
  double scaleStart = 1.0;
  ReportData reportData = ReportData();

  final controller = MapController(
    location: LatLng.degree(45.511280676982636, -122.68334923167914),
  );

  void t(Position? pos) {
    setState(() {
      if (pos != null) {
        reportData.dataPoints.add(DataPoint(pos, scanner.scanResults));
        location = pos;
        controller.center = LatLng.degree(pos.latitude, pos.longitude);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    positionStream =
        Geolocator.getPositionStream(locationSettings: Controllers.getLocationSettings(5)).listen((Position? position) {
      t(position);
    });

    scanner.scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanner.scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      // Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    scanner.isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      scanner.isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(controller: controller),
      floatingActionButton: scanButton(context),
    );
  }
}
