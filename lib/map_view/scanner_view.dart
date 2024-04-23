import 'dart:async';
import 'dart:io';

import 'package:bluetooth_detector/map_view/map_functions.dart';
import 'package:bluetooth_detector/map_view/map_view.dart';
import 'package:bluetooth_detector/report_view/report_view.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bluetooth_detector/report/report.dart';

part 'package:bluetooth_detector/map_view/buttons.dart';
part 'package:bluetooth_detector/map_view/scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  ScannerViewState createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  Position? location;
  late StreamSubscription<Position> positionStream;
  Offset? dragStart;
  double scaleStart = 1.0;
  ReportData reportData = ReportData();

  bool isScanning = false;
  late StreamSubscription<bool> isScanningSubscription;
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  List<ScanResult> scanResults = [];
  List<BluetoothDevice> systemDevices = [];

  late StreamSubscription<DateTime> timeStreamSubscription;
  static const int rescanTime = 10;

  final Stream<DateTime> _timeStream = Stream.periodic(const Duration(seconds: rescanTime), (int x) {
    return DateTime.now();
  });

  void log() {
    reportData.dataPoints.add(DataPoint(location, scanResults));
  }

  @override
  void initState() {
    super.initState();

    positionStream = Geolocator.getPositionStream(locationSettings: Controllers.getLocationSettings(30))
        .listen((Position? position) {
      setState(() {
        location = position;
      });
      if (isScanning) {
        log();
        rescan();
      }
    });

    scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
      scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      // Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });

    timeStreamSubscription = _timeStream.listen((currentTime) {
      if (isScanning) {
        log();
        rescan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(child: scanButton(context)),
    );
  }
}
