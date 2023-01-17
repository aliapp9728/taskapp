import 'package:flutter/material.dart';

class EditTaskProvider extends ChangeNotifier {
  final TextEditingController _controllerTask = TextEditingController();
  final TextEditingController _controllerAchivement = TextEditingController();
  TextEditingController get controllerTask => _controllerTask;
  TextEditingController get controllerAchivement => _controllerAchivement;
  // var _dateTextEditPro = DateFormat.yMEd().format(DateTime.now());
  // String get dateeTextEdit => _dateTextEditPro;
  var _dateTextEditProYear = '';
  String get dateTextEditProYear => _dateTextEditProYear;
  var _dateTextEditProMonth = '';
  String get dateTextEditProMonth => _dateTextEditProMonth;
  var _dateTextEditProToday = '';
  String get dateTextEditProToday => _dateTextEditProToday;

  var _dateOutFormatEdit = DateTime.now();
  DateTime get dateeOutFormatEdit => _dateOutFormatEdit;

  void changeDateEditProv(DateTime newDate) {
    _dateOutFormatEdit = newDate;
    // _dateOutFormatEdit = newDate;
    // _dateTextEditPro = DateFormat.yMEd().format(newDate);
    _dateTextEditProYear = newDate.year.toString();
    _dateTextEditProMonth = newDate.month.toString();
    _dateTextEditProToday = newDate.day.toString();
    // print('Selected Date Provider is $_dateTextEditPro');
    notifyListeners();
  }

  void dateeTextEditSet(
    String? dateTaskYear,
    String? dateTaskMonnth,
    String? dateTaskToday,
  ) {
    _dateTextEditProYear = dateTaskYear!;
    _dateTextEditProMonth = dateTaskMonnth!;
    _dateTextEditProToday = dateTaskToday!;
  }

  void dateOutFormatEditSet(DateTime? datOutFormat) {
    _dateOutFormatEdit = datOutFormat!;
  }
}
