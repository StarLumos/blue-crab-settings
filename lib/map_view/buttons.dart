part of 'package:bluetooth_detector/map_view/scanner_view.dart';

extension Buttons on ScannerViewState {
  Widget scanButton(BuildContext context) {
    if (location == null) {
      return FloatingActionButton.large(
        onPressed: () async {
          location = await getLocation();
          controller.center = LatLng.degree(location!.latitude, location!.longitude);
          setState(() {});
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.location_searching, color: colors.primaryText),
      );
    } else if (isScanningNow) {
      return FloatingActionButton.large(
        onPressed: () {
          log(location);
          stopScan();
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
          recenter();
          startScan();
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.play_arrow_rounded, color: colors.primaryText),
      );
    }
  }
}
