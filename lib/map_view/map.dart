import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:flutter/gestures.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/map_view/tile_servers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bluetooth_detector/map_view/scanner.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:bluetooth_detector/utils/snackbar.dart';

double clamp(double x, double min, double max) {
  if (x < min) x = min;
  if (x > max) x = max;
  return x;
}

class Destination {
  String label;
  LatLng location;
  Destination(this.label, this.location);
}

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Scanner scanner = Scanner();
  late Position location;

  final controller = MapController(
    location: LatLng.degree(45.511280676982636, -122.68334923167914),
  );

  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: getLocationSettings(100)).listen((Position? position) {
    print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
  });

  var markers = [
    Destination("My House", LatLng.degree(45.47233167853709, -122.58916397400984)),
    Destination("Baltimore", LatLng.degree(39.288842377026285, -76.64454136029799)),
    Destination("OMSI", LatLng.degree(45.51083352637069, -122.66665975037445)),
  ];

  @override
  void initState() {
    super.initState();

    scanner.scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanner.scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    scanner.isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      scanner.isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  static LocationSettings getLocationSettings(int distanceFilter) {
    LocationAccuracy accuracy = LocationAccuracy.high;
    if (Platform.isAndroid) {
      return AndroidSettings(
          accuracy: accuracy,
          distanceFilter: distanceFilter,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (Platform.isIOS || Platform.isMacOS) {
      return AppleSettings(
        accuracy: accuracy,
        activityType: ActivityType.fitness,
        distanceFilter: distanceFilter,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      return LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      );
    }
  }

  /// Determine the current position of the device.
  Future<Position> determinePosition() async {
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
    controller.center = LatLng.degree(position.latitude, position.longitude);

    return position;
  }

  void addPoint(Position position, String label) {
    setState(() {
      markers.add(Destination(label, LatLng.degree(position.latitude, position.longitude)));
    });
  }

  void onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? dragStart;
  double scaleStart = 1.0;
  void onScaleStart(ScaleStartDetails details) {
    dragStart = details.focalPoint;
    scaleStart = 1.0;
  }

  void onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - scaleStart;
    scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - dragStart!;
      dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget buildMarkerWidget(Offset pos, String label, Color color, [IconData icon = Icons.location_on]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 48,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(label),
            ),
          );
        },
      ),
    );
  }

  void startScan() async {
    location = await determinePosition();
    scanner.startScan();
  }

  void stopScan() {
    scanner.stopScan();
  }

  Widget scanButton(BuildContext context) {
    if (scanner.isScanningNow) {
      return FloatingActionButton(
        onPressed: stopScan,
        backgroundColor: colors.foreground,
        child: const Icon(
          Icons.stop,
          color: colors.primaryText,
        ),
      );
    } else {
      return FloatingActionButton(
        onPressed: startScan,
        backgroundColor: colors.foreground,
        child: const Icon(Icons.play_arrow_rounded, color: colors.primaryText),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MapLayout(
          controller: controller,
          builder: (context, transformer) {
            final markerWidgets =
                markers.map((e) => buildMarkerWidget(transformer.toOffset(e.location), e.label, Colors.red));

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
        floatingActionButton: scanButton(context));
  }
}
