import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ProvCalendar extends ChangeNotifier {
  var _calendarFormat = CalendarFormat.month;
  DateTime _currentDate = DateTime.now();
  var _dateTextCalender = DateFormat.yMEd().format(DateTime.now());
// _calendarFormat
  CalendarFormat get calendarFormat => _calendarFormat;

  void changeCalendarFormat(CalendarFormat newCalendarFormat) {
    _calendarFormat = newCalendarFormat;
    notifyListeners();
  }

// CurrentDate
  DateTime get currentDate => _currentDate;

  void changeCurrentDate(DateTime newCurrentDate) {
    _currentDate = newCurrentDate;
    notifyListeners();
  }

// dateTextCalender
  String get dateTextCalender => _dateTextCalender;

  void changeDateTextCalender(DateTime newdateTextCalendere) {
    _dateTextCalender = DateFormat.yMEd().format(newdateTextCalendere);
    // print('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
    // print('_dateTextCalender $_dateTextCalender');
    // print(
    //     '   DateFormat.yMEd() .format(DateTime.now() ${DateFormat.yMEd().format(DateTime.now())}');
    // print('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
    notifyListeners();
  }
}
