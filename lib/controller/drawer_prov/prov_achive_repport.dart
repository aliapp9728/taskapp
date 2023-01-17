import 'package:flutter/material.dart';

class AcheiveReportProv extends ChangeNotifier {
  List<String> yearListHalfAchive = [
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',
    '2041',
    '2042',
    '2043',
    '2044',
    '2045',
    '2046',
    '2047',
    '2048',
    '2049',
    '2050',
  ];
  List<String> monthListHalfAchive = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  String _initYear = DateTime.now().year.toString();
  String get initYear => _initYear;
  String _initMonth = DateTime.now().month.toString();
  String get initMonth => _initMonth;

  changeInitYear(String newYear) {
    _initYear = newYear;
    notifyListeners();
  }

  changeInitMonth(String newMonth) {
    _initMonth = newMonth;
    notifyListeners();
  }
}
