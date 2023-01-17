import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskjob_aliapp/db_helper/dbhelper.dart';
import 'package:taskjob_aliapp/main.dart';
import 'package:taskjob_aliapp/model/progress_model.dart';
import 'package:taskjob_aliapp/model/task_uncomp.dart';

class HomeProvider extends ChangeNotifier {
  bool _valueSwitchProgress = false;
  bool _isControllerTaskActive = false;
  bool _isControllerAchiveActive = false;
  bool _showTasksHomeCalenderEditScreen = true;
  int _changeColor = 1;

  int get changeColor => _changeColor;
  bool get showTasksHomeCalenderEditScreen => _showTasksHomeCalenderEditScreen;
  bool get valueSwitchProgress => _valueSwitchProgress;
  bool get isControllerTaskActive => _isControllerTaskActive;
  bool get isControllerAchiveActive => _isControllerAchiveActive;

  changeChangeColor(int newValue) {
    _changeColor = newValue;
    notifyListeners();
  }

  changeShowTasksHomeCalenderEditScreen(bool showIt) {
    _showTasksHomeCalenderEditScreen = showIt;
    notifyListeners();
  }

  changeConrollerTaskActive(bool taskBool) {
    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n \n');
    // print('It    Task $taskBool \n \n');
    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n \n');
    // print('It changeConrollerTaskActive $taskBool');
    _isControllerTaskActive = taskBool;
    _isControllerAchiveActive;
    notifyListeners();
  }

  changeConrollerAchiveActive(bool achiveBool) {
    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n \n');
    // print('It changeConrollerAchiveActive  Achive $achiveBool \n \n');
    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n \n');
    _isControllerAchiveActive = achiveBool;
    _isControllerTaskActive;
    notifyListeners();
  }

  changeValueSwitchPorog(bool vewValue) {
    // print('It Changed $vewValue');
    _valueSwitchProgress = vewValue;
    notifyListeners();
  }

  // ssssssssssssssssssssssssssssssssssss
  int _page = 1;
  int get page => _page;
  bool _isTodayBreakProv = isTodayBreak;
  bool get isTodayBreakProv => _isTodayBreakProv;

  var _dateTextWithoutDayname = DateFormat.yMd().format(DateTime.now());
  var _dateText = DateFormat.yMEd().format(DateTime.now());

  var _dateOutFormat = DateTime.now();
  String get dateTextWithoutDayname => _dateTextWithoutDayname;
  String get dateeText => _dateText;
  DateTime get dateeOutFormat => _dateOutFormat;
  var taskList = <DoTask>[];
  var progressList = <ProgressTasks>[];
  double progres = 0;
  bool _checkBoxValue = false;
  int isCompleted = 0;
  changePage(int newPage) {
    _page = newPage;
    // print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    // print('new Page $newPage');
    // print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    notifyListeners();
  }

  bool get checkBoxValue => _checkBoxValue;
  // int get iisCompleted => isCompleted;
  changeCheckBox(bool valueSign, int id) {
    // print('Value Box is $valueSign');
    if (valueSign) {
      _checkBoxValue = true;
      isCompleted = 1;
      markTaskCompleted(id, isCompleted);
    } else if (valueSign == false) {
      _checkBoxValue = false;
      isCompleted = 0;
      markTaskCompleted(id, isCompleted);
    }
    // print('The isCompleted is $isCompleted');
  }

  changeIsTodayBreak(bool isTodayBreakMeth) async {
    isTodayBreak = isTodayBreakMeth;
    _isTodayBreakProv = isTodayBreak;
    // print('ggggg $_isTodayBreakProv');
    // print('$isTodayBreak');
    // print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS$isTodayBreak');
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isTodayBreak', isTodayBreakMeth);
  }

  Future<int> addTask({DoTask? task}) {
    return DbHelper.insertTask(task);
  }

  Future<void> getTask() async {
    // print('Before Query %%%%%%%%%%%%%%%%%');
    final List<Map<String, Object?>> tasks = await DbHelper.queryyTask();

    // print('Tasks length ${tasks.length} %%%%%%%%%%%%%%%%%');
    //  The method fo assignAll it brings big data at once
    // taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    taskList = [];
    // print('Tasks list before add is ${taskList.length}');
    taskList.addAll(tasks.map((data) => DoTask.fromJson(data)).toList());

    // print('Tasks list after add is ${taskList.length}');
    notifyListeners();
  }

  Future<void> deleteTask(DoTask task) async {
    await DbHelper.deleteTask(task);
    // print("Task List after delete is ${taskList.length}");
    getTask();
    notifyListeners();
  }

  void deleteAllTask() async {
    await DbHelper.deleteAllTasks();
    getTask();
    notifyListeners();
  }

  // void markTaskCompleted(int id) async {
  //   await DbHelper.update(id);
  //   getTask();
  // }
  void updateTextTask(int id, String newTextTask) async {
    await DbHelper.upDateTextOfTask(id, newTextTask);
    getTask();
    notifyListeners();
  }

  Future<void> updateDateTaskProvYear(int id, String newDateYear) async {
    await DbHelper.updateDateYearTask(id, newDateYear);
    getTask();
    notifyListeners();
  }

  Future<void> updateDateTaskProvMonth(int id, String newDateMonth) async {
    await DbHelper.updateDateMonthTask(id, newDateMonth);
    getTask();
    notifyListeners();
  }

  Future<void> updateDateTaskProvToday(int id, String newDateToday) async {
    await DbHelper.upDateDateTodayTask(id, newDateToday);
    getTask();
    notifyListeners();
  }

  void markTaskAchivement(int id, String achive) async {
    await DbHelper.upDateAchivementOfTask(id, achive);
    getTask();
    notifyListeners();
  }

  void markTaskCompleted(int id, int change) async {
    await DbHelper.upDateCompletedOfTask(id, change);
    getTask();
    // print('Mark Coplete is called ID is $id Change is $change');
    notifyListeners();
  }

  // void increaseprog() {
  //   print('Increeesed');
  //   progres += 0.25;
  //   notifyListeners();
  // }

  void changeDate(DateTime newDate) async {
    await initializeDateFormatting("ar_SA", null);
    // var now = DateTime.now();
    // var formatter = DateFormat.yMEd('ar_SA');
    // String formatted = formatter.format(now);
    // print('DateFormat.yMMMd(ar_SA) DateFormat.yMMMd(ar_SA)');
    // print(formatter.locale);
    // print('DateFormat.yMMMd(ar_SA) DateFormat.yMMMd(ar_SA)');
    // print('//////////////////////////////////////////////////////////');
    // print(
    //     'String formatted = formatter.format(now); String formatted = formatter.format(now);');
    // print(formatted);
    // print(
    //     'String formatted = formatter.format(now); String formatted = formatter.format(now);)');
    _dateTextWithoutDayname = DateFormat.yMd().format(newDate);
    _dateOutFormat = newDate;
    _dateText = DateFormat.yMEd().format(newDate);
    // print('Selected Date Provider AAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    // print('Selected Date Provider is $_dateText');
    notifyListeners();
  }

  // =============================================================
  // =============================================================
  // =============================================================
  // =============================================================
  // =============================================================
  // =============================================================
  // =============================================================
  // Progress Provider Method

  Future<int> addProgress({ProgressTasks? progressTasks}) {
    return DbHelper.insertProgress(progressTasks);
  }

  Future<void> getProgress() async {
    // print('Before Query Progress %%%%%%%%%%%%%%%%%');
    final List<Map<String, Object?>> progresses =
        await DbHelper.queryyProgress();
    // print('Progress list after add is $progresses');
    // print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');

    // print('Progress length ${progresses.length} %%%%%%%%%%%%%%%%%');
    //  The method fo assignAll it brings big data at once
    // taskList.assignAll(progresses.map((data) => Task.fromJson(data)).toList());
    progressList = [];
    // print('Progress list before add is ${progressList.length}');
    progressList.addAll(
        progresses.map((data) => ProgressTasks.fromJson(data)).toList());

    // print('Progress list after add is ${progressList.length}');

    notifyListeners();
  }

  Future<void> deleteProgress(ProgressTasks progressTasks) async {
    await DbHelper.deleteProgress(progressTasks);
    // print("Progress List after delete is ${progressList.length}");
    getProgress();
    notifyListeners();
  }

  void updateProgress(String dateProgress, double newProgress) async {
    // print("New Progress after update is $newProgress");
    await DbHelper.upDateProgress(dateProgress, newProgress);
    getProgress();
    notifyListeners();
  }

  void updateisTodayBreakProgress(
      String dateProgress, String newisTodayBreak) async {
    await DbHelper.upDateisTodayBreak(dateProgress, newisTodayBreak);
    getProgress();
    notifyListeners();
  }
}
