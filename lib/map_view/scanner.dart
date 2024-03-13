import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';
import 'dart:async';

class Scanner {
  bool isScanning = false;
  late StreamSubscription<bool> isScanningSubscription;
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  List<ScanResult> scanResults = [];
  List<BluetoothDevice> systemDevices = [];
  bool get isScanningNow => FlutterBluePlus.isScanningNow;

  Scanner() {
    scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanResults = results;
    });

    isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      isScanning = state;
    });
  }

  void dispose() {
    scanResultsSubscription.cancel();
    isScanningSubscription.cancel();
  }

  Future startScan() async {
    systemDevices = await FlutterBluePlus.systemDevices;
    // android is slow when asking for all advertisements,
    // so instead we only ask for 1/8 of them
    int divisor = Platform.isAndroid ? 8 : 1;
    await FlutterBluePlus.startScan(continuousUpdates: true, continuousDivisor: divisor);
  }

  Future stopScan() async {
    FlutterBluePlus.stopScan();
  }
}
