import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';

class AppButtonStyle {
  static ButtonStyle enableBluetoothButtonStyle = ButtonStyle(
    iconColor: MaterialStateProperty.all(colors.primaryText),
    foregroundColor: MaterialStateProperty.all(colors.primaryText),
    backgroundColor: MaterialStateProperty.all(colors.foreground),
    overlayColor: MaterialStateProperty.all(colors.altText),
    shadowColor: MaterialStateProperty.all(colors.transparent),
    surfaceTintColor: MaterialStateProperty.all(colors.transparent),
  );

  static ButtonStyle deviceButtonStyle = ButtonStyle(
    iconColor: MaterialStateProperty.all(colors.primaryText),
    foregroundColor: MaterialStateProperty.all(colors.primaryText),
    backgroundColor: MaterialStateProperty.all(colors.foreground),
    overlayColor: MaterialStateProperty.all(colors.altText),
    shadowColor: MaterialStateProperty.all(colors.transparent),
    surfaceTintColor: MaterialStateProperty.all(colors.transparent),
    shape:
        MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
  );
}
