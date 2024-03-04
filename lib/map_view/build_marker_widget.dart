import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';

Widget buildMarkerWidget(BuildContext context, Offset pos, Color color, [IconData icon = Icons.location_on]) {
  return Positioned(
    left: pos.dx - 24,
    top: pos.dy - 24,
    width: 48,
    height: 48,
    child: GestureDetector(
      child: Stack(children: [
        const Icon(Icons.circle, color: colors.primaryText, size: 48),
        Icon(
          icon,
          color: color,
          size: 48,
        ),
      ]),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Text("Data Here"),
          ),
        );
      },
    ),
  );
}
