import 'package:bluetooth_detector/assigned_numbers/company_identifiers.dart';
import 'package:bluetooth_detector/report_view/device_map_view.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/styles/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:bluetooth_detector/report/device.dart';

class DeviceView extends StatelessWidget {
  DeviceIdentifier deviceID;
  Report report;
  late Device device = report[deviceID]!;
  late Iterable<String> manufacturers = device.data.manufacturerData.keys
      .map((e) => company_identifiers[e.toRadixString(16).toUpperCase().padLeft(4, "0")] ?? "Unknown");

  DeviceView({super.key, required this.deviceID, required this.report});

  Widget DataRow(String label, String value) {
    if (value.isEmpty) {
      return SizedBox.shrink();
    }
    String text = label;
    if (label.isNotEmpty) {
      text += ": ";
    }
    text += value;

    return Text(text, style: const TextStyle(color: colors.primaryText), textAlign: TextAlign.left);
  }

  Widget Tile(String label, Object value, [Color? color = null]) {
    return Container(color: color, child: Center(child: Column(children: [Text(label), Text(value.toString())])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SafeArea(
                              child: DeviceMapView(
                            device: deviceID,
                            report: report,
                          ))));
            },
            style: AppButtonStyle.buttonWithBackground,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DataRow("", device.id.toString()),
              DataRow("Name", device.data.advName),
              DataRow("Platform", device.platformName),
              DataRow("Manufacturer", manufacturers.join(", ")),
              Table(columnWidths: const {
                0: FlexColumnWidth(1.0),
                1: FlexColumnWidth(1.0),
                2: FlexColumnWidth(1.0),
              }, children: [
                TableRow(children: [
                  Tile("Incidence", device.incidence, colors.altText),
                  Tile("Areas", device.areas.length, colors.background),
                  Tile("Locations", device.locations.length),
                ])
              ]),
            ])));
  }
}
