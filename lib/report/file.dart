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
  var result = ReportData();
  final completer = Completer<ReportData>();
  asyncFunction().then((_) {
    completer.complete();
  });
  completer.future.then((value) {
    result = value;
  });
  return result;
}

Future<ReportData> asyncFunction() async {
  try {
    final file = await _localFile;
    final fileData = await file.readAsString();
    final result = ReportData.fromJson(jsonDecode(fileData));
    return result;
  } catch (e) {
    return ReportData();
  }
}
