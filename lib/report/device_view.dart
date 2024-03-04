import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';

class DeviceView extends StatefulWidget {
  String uuid;

  DeviceView({super.key, required this.uuid});

  @override
  DeviceViewState createState() => DeviceViewState();
}

class DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.uuid, style: const TextStyle(color: colors.primaryText));
  }
}
