import 'dart:convert';
import 'dart:io';
import 'package:bluetooth_detector/report/report_data.dart';
import 'package:path_provider/path_provider.dart';

Future<File> get _localFile async {
  final path = (() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  })();
  return File('$path/reports.json');
}

Future<File> write(ReportData reportData) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('${reportData.toJson()}');
}

ReportData read() {
  try {
    final file = _localFile.then((() {})());
    final fileData = await file.readAsString();
    final result = ReportData.fromJson(jsonDecode(fileData));
    return result;
  } catch (e) {
    return ReportData();
  }
}
