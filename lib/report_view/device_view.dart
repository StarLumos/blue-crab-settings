import 'package:bluetooth_detector/assigned_numbers/company_identifiers.dart';
import 'package:bluetooth_detector/report_view/device_map_view.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/styles/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceView extends StatelessWidget {
  DeviceIdentifier deviceID;
  Report report;
  late Device device = report[deviceID]!;
  late BluetoothDevice deviceData = device.device;
  late Iterable<String> manufacturers = device.data.manufacturerData.keys
      .map((e) => company_identifiers[e.toRadixString(16).toUpperCase().padLeft(4, "0")] ?? "Unknown");

  DeviceView({super.key, required this.deviceID, required this.report});

  Widget DataRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: colors.primaryText)),
        if (label.isNotEmpty) Text(": ", style: const TextStyle(color: colors.primaryText)),
        Text(value.toString(), style: const TextStyle(color: colors.primaryText)),
      ],
    );
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
            child: Column(children: [
              DataRow("", deviceData.remoteId.toString()),
              if (!deviceData.advName.isEmpty) DataRow("Name", deviceData.advName),
              if (!deviceData.platformName.isEmpty) DataRow("Platform", deviceData.platformName),
              if (!manufacturers.isEmpty) DataRow("Manufacturer", manufacturers.join(", ")),
              Table(columnWidths: const {
                0: FlexColumnWidth(1.0),
                1: FlexColumnWidth(1.0),
                2: FlexColumnWidth(1.0),
              }, children: [
                TableRow(children: [
                  Tile("Incidence", device.incidence, colors.altText),
                  Tile("Text2", device.incidence, colors.background),
                  Tile("Text3", device.incidence),
                ])
              ]),
            ])));
  }
}
