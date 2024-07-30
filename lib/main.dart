import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

void main() {
  runApp(const App());
}

void save(scanTime, thresholdTime, scanDistance, thresholdDistance) {
  double finalScanTime = scanTime;
  double finalThresholdTime = thresholdTime;
  double finalScanDistance = scanDistance;
  double finalThresholdDistance = thresholdDistance;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Crab: Bluetooth detector',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SettingsView(),
    );
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class LocationHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddLocation;

  LocationHeader({required this.onAddLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.background,
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: onAddLocation,
        ),
        title: Text("Add New Safe Zone"),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SettingsViewState extends State<SettingsView> {
  List<LatLng> locations = [
    LatLng.degree(111.111, 222.222),
    LatLng.degree(333.333, 444.444),
    LatLng.degree(555.555, 777.777),
    LatLng.degree(888.888, 999.999),
  ];

  double scanTime = 20;
  double thresholdTime = 20;
  double scanDistance = 20;
  double thresholdDistance = 20;

  void _addLocation() {
    setState(() {
      locations.insert(0, LatLng.degree(123.456, 789.012));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Safe Zones",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text('Scanning Time', style: TextStyle(fontSize: 18)),
            Slider(
              min: 0.0,
              max: 100.0,
              value: scanTime,
              onChanged: (newValue) {
                setState(() {
                  scanTime = newValue;
                  if (scanTime > thresholdTime) {
                    thresholdTime = scanTime;
                  } else {
                    thresholdTime = thresholdTime;
                  }
                  save(
                      scanTime, thresholdTime, scanDistance, thresholdDistance);
                });
              },
            ),
            Text('Scanning Time threshold', style: TextStyle(fontSize: 18)),
            Slider(
              min: 0.0,
              max: 100.0,
              value: thresholdTime,
              onChanged: (newValue) {
                setState(() {
                  if (newValue < scanTime) {
                    thresholdTime = scanTime;
                  } else {
                    thresholdTime = newValue;
                  }
                  save(
                      scanTime, thresholdTime, scanDistance, thresholdDistance);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Distance",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text('Scanning Distance', style: TextStyle(fontSize: 18)),
            Slider(
              min: 0.0,
              max: 100.0,
              value: scanDistance,
              onChanged: (newValue) {
                setState(() {
                  scanDistance = newValue;
                  if (scanDistance > thresholdDistance) {
                    thresholdDistance = scanDistance;
                  } else {
                    thresholdDistance = thresholdDistance;
                  }
                  save(
                      scanTime, thresholdTime, scanDistance, thresholdDistance);
                });
              },
            ),
            Text('Scanning Distance threshold', style: TextStyle(fontSize: 18)),
            Slider(
              min: 0.0,
              max: 100.0,
              value: thresholdDistance,
              onChanged: (newValue) {
                setState(() {
                  if (newValue < scanDistance) {
                    thresholdDistance = scanDistance;
                  } else {
                    thresholdDistance = newValue;
                  }
                  save(
                      scanTime, thresholdTime, scanDistance, thresholdDistance);
                });
              },
            ),
            Flexible(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Safe Zones",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LocationHeader(onAddLocation: _addLocation),
                  ...locations.map((location) => ListTile(
                        title: Text(
                            'Latitude: ${location.latitude}, Longitude: ${location.longitude}'),
                      )),
                ]))),
          ],
        ),
      ),
    );
  }
}
