part of 'package:bluetooth_detector/map_view/map_view.dart';

extension Buttons on MapViewState {
  Widget scanButton(BuildContext context) {
    if (location == null) {
      return FloatingActionButton(
        onPressed: () async {
          location = await getLocation();
          controller.center = LatLng.degree(location!.latitude, location!.longitude);
          setState(() {});
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.location_searching, color: colors.primaryText),
      );
    } else if (scanner.isScanningNow) {
      return FloatingActionButton(
        onPressed: () {
          t(location);
          scanner.stopScan();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SafeArea(child: ReportView(reportData: reportData))));
        },
        backgroundColor: colors.altText,
        child: const Icon(
          Icons.stop,
          color: colors.primaryText,
        ),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          reportData = ReportData();
          scanner.startScan();
        },
        backgroundColor: colors.foreground,
        child: const Icon(Icons.play_arrow_rounded, color: colors.primaryText),
      );
    }
  }
}
