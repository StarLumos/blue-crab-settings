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

Future<String> read() async {
  try {
    final file = await _localFile;

    // Read the file
    return file.readAsString();
  } catch (e) {
    return "";
  }
}
