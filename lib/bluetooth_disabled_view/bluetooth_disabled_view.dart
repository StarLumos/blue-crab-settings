import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/styles/button_styles.dart';

class BluetoothOffView extends StatelessWidget {
  const BluetoothOffView({super.key});

  Widget bluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: colors.primaryText,
    );
  }

  Widget turnOnBluetoothButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        style: AppButtonStyle.enableBluetoothButtonStyle,
        child: const Text('TURN ON'),
        onPressed: () async {
          try {} catch (e) {
            // Snackbar.show(ABC.a, prettyException("Error Turning On:", e), success: false);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      // key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              bluetoothOffIcon(context),
              if (Platform.isAndroid) turnOnBluetoothButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
