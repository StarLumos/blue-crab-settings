import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bluetooth_detector/map_view/build_marker_widget.dart';
import 'package:bluetooth_detector/map_view/scanner.dart';
import 'package:bluetooth_detector/map_view/tile_servers.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/report_view/report_view.dart';

part 'package:bluetooth_detector/map_view/map_view_controllers.dart';
part 'package:bluetooth_detector/map_view/buttons.dart';

double clamp(double x, double min, double max) {
  if (x < min) x = min;
  if (x > max) x = max;
  return x;
}

class MapView extends StatefulWidget {
  final List<LatLng> markers;

  const MapView({super.key, required this.markers});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Scanner scanner = Scanner();
  Position? location;
  late StreamSubscription<Position> positionStream;
  Offset? dragStart;
  double scaleStart = 1.0;
  ReportData reportData = ReportData();

  final controller = MapController(
    location: LatLng.degree(45.511280676982636, -122.68334923167914),
  );

  void t(Position? pos) {
    setState(() {
      if (pos != null) {
        reportData.dataPoints.add(DataPoint(pos, scanner.scanResults));
        location = pos;
        controller.center = LatLng.degree(pos.latitude, pos.longitude);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    positionStream =
        Geolocator.getPositionStream(locationSettings: Controllers.getLocationSettings(5)).listen((Position? position) {
      t(position);
    });

    scanner.scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanner.scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      // Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    scanner.isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      scanner.isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  /// Determine the current position of the device.
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void addPoint(Position position) {
    setState(() {
      widget.markers.add(LatLng.degree(position.latitude, position.longitude));
    });
  }

  void startScan() async {
    scanner.startScan();
  }

  void stopScan() {
    scanner.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          List<Widget> markerWidgets = widget.markers
              .map((location) => buildMarkerWidget(context, transformer.toOffset(location), Colors.red))
              .toList();
          if (location != null) {
            markerWidgets.add(buildMarkerWidget(
                context,
                transformer.toOffset(LatLng.degree(location!.latitude, location!.longitude)),
                colors.foreground,
                Icons.account_circle));
          }
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: onScaleStart,
            onScaleUpdate: (details) => onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  transformer.setZoomInPlace(
                      clamp(controller.zoom + event.scrollDelta.dy / -1000.0, 2, 18), event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;

                      return CachedNetworkImage(
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  ...markerWidgets,
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: scanButton(context),
    );
  }
}
