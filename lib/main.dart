import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  List<LatLng> locations = [
    LatLng.degree(111.111, 222.222),
    LatLng.degree(333.333, 444.444),
    LatLng.degree(555.555, 777.777),
    LatLng.degree(888.888, 999.999),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Spacer(),
      ),
    );
  }
}
