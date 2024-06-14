import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bluetooth_detector/report/report_data.dart';
import 'package:path_provider/path_provider.dart';

Future<File> get _localFile async {
  final Directory directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/reports.json');
}

Future<File> write(ReportData reportData) async {
  final File file = await _localFile;
  final data = reportData.toJson().toString();

  // Write the file
  return file.writeAsString('${data}');
}

ReportData read() {
  ReportData result = ReportData();
  asyncFunction().then((ReportData data) {
    result = data;
  });
  return result;
}

Future<ReportData> asyncFunction() async {
  try {
    File file = await _localFile;
    String fileData = await file.readAsString();
    ReportData result = ReportData.fromJson(jsonDecode(fileData));
    return result;
  } catch (e) {
    return ReportData();
  }
}
