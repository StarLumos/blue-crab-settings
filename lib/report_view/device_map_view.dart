import 'package:bluetooth_detector/map_view/map_functions.dart';
import 'package:bluetooth_detector/map_view/map_view.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/styles/button_styles.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:map/map.dart';

class DeviceMapView extends StatefulWidget {
  final DeviceIdentifier device;
  final Report report;

  const DeviceMapView({super.key, required this.device, required this.report});

  @override
  DeviceMapViewState createState() => DeviceMapViewState();
}

class DeviceMapViewState extends State<DeviceMapView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MapView(
        markers: widget.report[widget.device]!.locations.toList(),
        controller: MapController(location: middlePoint(widget.report[widget.device]!.locations.toList())),
      ),
      BackButton(
        color: colors.primaryText,
        onPressed: () => Navigator.pop(context),
        style: AppButtonStyle.buttonWithBackground,
      ),
    ]);
  }
}
