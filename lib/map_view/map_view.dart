import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bluetooth_detector/map_view/build_marker_widget.dart';
import 'package:bluetooth_detector/map_view/tile_servers.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

part 'package:bluetooth_detector/map_view/map_view_controllers.dart';

double clamp(double x, double min, double max) {
  if (x < min) x = min;
  if (x > max) x = max;
  return x;
}

class MapView extends StatefulWidget {
  List<LatLng> markers;
  MapController? controller;

  MapView({
    super.key,
    this.markers = const [],
    this.controller,
  });

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  Position? location;
  late StreamSubscription<Position> positionStream;
  Offset? dragStart;
  double scaleStart = 1.0;
  bool followUser = true;

  @override
  void initState() {
    super.initState();

    widget.controller = widget.controller ??
        MapController(
          location: LatLng.degree(45.511280676982636, -122.68334923167914),
        );

    positionStream =
        Geolocator.getPositionStream(locationSettings: Controllers.getLocationSettings(5)).listen((Position? position) {
      location = position;
      if (followUser) {
        widget.controller!.center = LatLng.degree(position!.latitude, position.longitude);
      }
      setState() {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLayout(
        controller: widget.controller!,
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
                      clamp(widget.controller!.zoom + event.scrollDelta.dy / -1000.0, 2, 18), event.localPosition);
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
    );
  }
}
