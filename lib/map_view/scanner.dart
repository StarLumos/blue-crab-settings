part of 'package:bluetooth_detector/map_view/scanner_view.dart';

extension Scanner on ScannerViewState {
  void dispose() {
    scanResultsSubscription.cancel();
    isScanningSubscription.cancel();
  }

  Future startScan() async {
    // android is slow when asking for all advertisements,
    // so instead we only ask for 1/8 of them
    await FlutterBluePlus.startScan(continuousUpdates: true, continuousDivisor: Platform.isAndroid ? 8 : 1);
  }

  Future stopScan() async {
    FlutterBluePlus.stopScan();
  }

  void rescan() {
    setState(() {
      stopScan();
      startScan();
    });
  }
}
