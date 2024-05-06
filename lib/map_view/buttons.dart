part of 'package:bluetooth_detector/map_view/scanner_view.dart';

extension Buttons on ScannerViewState {
  Widget scanButton(BuildContext context) {
    if (location == null) {
      return FloatingActionButton.large(
        onPressed: () async {
          location = await getLocation();
          setState(() {});
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.location_searching, color: colors.primaryText),
      );
    } else if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton.large(
        onPressed: () {
          log();
          stopScan();
          Vibration.vibrate(
              pattern: [250, 100, 100, 100, 100, 100, 250, 100, 500, 250, 250, 100, 750, 500],
              intensities: [255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0]);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SafeArea(child: ReportView(reportData: reportData))));
        },
        backgroundColor: colors.altText,
        child: const Icon(Icons.stop, color: colors.primaryText),
      );
    } else {
      return FloatingActionButton.large(
        onPressed: () {
          reportData = ReportData();
          startScan();
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.play_arrow_rounded, color: colors.primaryText),
      );
    }
  }
}
