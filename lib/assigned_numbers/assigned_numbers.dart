import 'package:bluetooth_detector/assigned_numbers/company_identifiers.dart' as ids;

class AssignedNumbers {
  Map<String, String> company_identifiers = ids.company_identifiers;

  AssignedNumbers() {
    for (var company in company_identifiers.values) {
      print(company);
    }
  }
}
