import 'package:bluetooth_detector/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_detector/report/device_view.dart';
import 'package:bluetooth_detector/report/report.dart';

class ReportView extends StatefulWidget {
  Report report;
  ReportView({super.key, required this.report});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.background,
        body: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: colors.foreground)))
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...widget.report.getDevices().map((e) => DeviceView(device: e)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
