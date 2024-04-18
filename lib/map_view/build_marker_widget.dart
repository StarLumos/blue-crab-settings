import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';

Widget buildMarkerWidget(BuildContext context, Offset pos, Icon icon, bool backgroundCircle) {
  return Positioned(
    left: pos.dx - 24,
    top: pos.dy - 24,
    width: 48,
    height: 48,
    child: GestureDetector(
      child:
          Stack(children: [if (backgroundCircle) Icon(Icons.circle, color: colors.primaryText, size: icon.size), icon]),
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
