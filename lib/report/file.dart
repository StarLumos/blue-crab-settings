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

Future<ReportData> read() async {
  try {
    return _localFile.then((file) {
      return file.readAsString().then((fileData) {
        return ReportData.fromJson(jsonDecode(fileData));
      });
    });
  } catch (e) {
    return ReportData();
  }
}
