import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_detector/report/device_view.dart';
import 'package:bluetooth_detector/report/report.dart';

class ReportView extends StatefulWidget {
  ReportData reportData;
  late Report report;
  ReportView({super.key, required this.reportData});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  @override
  void initState() {
    super.initState();
    widget.report = widget.reportData.generateReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: Stack(children: [
                    Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text("Report", textAlign: TextAlign.center, style: TextStyles.title),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close, color: colors.primaryText))
                      ],
                    ),
                  ])),
              Column(
                children: [
                  ...widget.report.keys.map((e) => DeviceView(device: e, report: widget.report)),
                ],
              ),
            ],
          ),
        ));
  }
}
