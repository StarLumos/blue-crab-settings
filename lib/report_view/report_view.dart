import 'package:bluetooth_detector/styles/colors.dart';
import 'package:bluetooth_detector/styles/button_styles.dart';
import 'package:bluetooth_detector/styles/text_styles.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_detector/report_view/device_view.dart';
import 'package:bluetooth_detector/report/report.dart';
import 'package:bluetooth_detector/report/report_data.dart';

class ReportView extends StatefulWidget {
  final ReportData reportData;
  ReportView({super.key, required this.reportData});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  late Report report;

  @override
  void initState() {
    super.initState();
    report = widget.reportData.generateReport();
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
                    BackButton(
                      color: colors.primaryText,
                      onPressed: () => Navigator.pop(context),
                      style: AppButtonStyle.buttonWithoutBackground,
                    )
                  ])),
              Column(
                children: [
                  ...report.report.keys
                      .sorted((a, b) =>
                          report.report[a]!.locations().length.compareTo(report.report[b]!.locations().length))
                      .reversed
                      .map((e) => DeviceView(deviceID: e, report: report)),
                ],
              ),
            ],
          ),
        ));
  }
}
