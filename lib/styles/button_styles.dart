import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';

class AppButtonStyle {
  static ButtonStyle enableBluetoothButtonStyle = ButtonStyle(
    iconColor: WidgetStateProperty.all(colors.primaryText),
    foregroundColor: WidgetStateProperty.all(colors.primaryText),
    backgroundColor: WidgetStateProperty.all(colors.foreground),
    overlayColor: WidgetStateProperty.all(colors.altText),
    shadowColor: WidgetStateProperty.all(colors.transparent),
    surfaceTintColor: WidgetStateProperty.all(colors.transparent),
  );

  static ButtonStyle buttonWithBackground = ButtonStyle(
    iconColor: WidgetStateProperty.all(colors.primaryText),
    foregroundColor: WidgetStateProperty.all(colors.primaryText),
    backgroundColor: WidgetStateProperty.all(colors.foreground),
    overlayColor: WidgetStateProperty.all(colors.altText),
    shadowColor: WidgetStateProperty.all(colors.transparent),
    surfaceTintColor: WidgetStateProperty.all(colors.transparent),
    shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
  );

  static ButtonStyle buttonWithoutBackground = ButtonStyle(
    iconColor: WidgetStateProperty.all(colors.primaryText),
    foregroundColor: WidgetStateProperty.all(colors.primaryText),
    overlayColor: WidgetStateProperty.all(colors.altText),
    shadowColor: WidgetStateProperty.all(colors.transparent),
    surfaceTintColor: WidgetStateProperty.all(colors.transparent),
    shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
  );
}
