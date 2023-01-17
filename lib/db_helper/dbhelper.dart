import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskjob_aliapp/model/progress_model.dart';
import 'package:taskjob_aliapp/model/task_uncomp.dart';

class DbHelper {
  static const String _tableTasks = 'taskes';
  static const String _tableProgress = 'progresses';
  static const int _version = 1;
  static Database? _db;

  static Future<void> initDatabase() async {
    if (_db != null) {
      debugPrint('Db is not null');
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}taskes.db';
        debugPrint('In Database path');
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          Batch batch = db.batch();
          print('onCreate has called');
          // AUTOINCREMENT
          batch.execute('CREATE TABLE $_tableTasks '
              '(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
              'task STRING, '
              'dateYearTask STRING, '
              'dateMonthTask STRING, '
              'dateTodayTask STRING, '
              'isCompleted INTEGER, '
              'achivement STRING)');
          // ===================================================
          // Progress Table
          // ===================================================
          batch.execute('CREATE TABLE $_tableProgress '
              '(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
              'progressOfDay REAL, '
              'isTodayBreak STRING, '
              'dateProgress STRING, '
              'dateProgressYear STRING, '
              'dateProgressmonth STRING, '
              'dateProgressToday STRING)');
          await batch.commit();
        });
        // debugPrint('Database is ready until now');
      } catch (e) {
        print('The Proplem in Database is $e');
      }
    }
  }

  Future<void> deleteDatabase() async {
    print('=====================================');
    print('======Datebase has benn deleted');
    return await databaseFactory
        .deleteDatabase('${await getDatabasesPath()}taskes.db');
  }

  static Future<int> insertTask(DoTask? doTask) async {
    print('Insert is called');
    return await _db!.insert(_tableTasks, doTask!.toJson());
  }

  static Future<int> deleteAllTasks() async {
    print('delete Function called');
    return await _db!.delete(_tableTasks);
  }

  static Future<int> deleteTask(DoTask? doTask) async {
    print('Delete is called');
    return await _db!
        .delete(_tableTasks, where: 'id = ?', whereArgs: [doTask?.id]);
  }

  static Future<int> upDateTextOfTask(int id, String newText) async {
    print('upDate Completed is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET task = ?
    WHERE id = ?
 

    ''', [newText, id]);
  }

  static Future<int> updateDateYearTask(int id, String newDateYear) async {
    print('upDate Completed is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET dateYearTask = ?
    WHERE id = ?
 

    ''', [newDateYear, id]);
  }

  static Future<int> updateDateMonthTask(int id, String newDateMonth) async {
    print('upDate Completed is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET dateMonthTask = ?
    WHERE id = ?
 

    ''', [newDateMonth, id]);
  }

  static Future<int> upDateDateTodayTask(int id, String newDateToday) async {
    print('upDate Completed is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET dateTodayTask = ?
    WHERE id = ?
 

    ''', [newDateToday, id]);
  }

  static Future<int> upDateCompletedOfTask(int id, int change) async {
    print('upDate Completed is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET isCompleted = ?
    WHERE id = ?
 

    ''', [change, id]);
  }

  static Future<int> upDateAchivementOfTask(int id, String achive) async {
    print('upDate Achivement is called');
    return await _db!.rawUpdate('''
    UPDATE taskes
    SET achivement = ?
    WHERE id = ?
 

    ''', [achive, id]);
  }

  static Future<List<Map<String, dynamic>>> queryyTask() async {
    // تستفر عن وجود هذه البيانات  في الداتا بيس
    print('Queryy is called');
    return await _db!.query(_tableTasks);
  }

// ============================================================
// =============================================================
// ============================================================
// =============================================================
// ============================================================
// =============================================================
// ============================================================
// =============================================================
// ============================================================
// =============================================================
// Method of Progress

  static Future<int> insertProgress(ProgressTasks? progressTasks) async {
    print('Insert of Progress is called');
    return await _db!.insert(_tableProgress, progressTasks!.toJson());
  }

  static Future<int> deleteProgress(ProgressTasks? progressTasks) async {
    print('Delete of Progress is called');
    return await _db!.delete(_tableProgress,
        where: 'id = ?', whereArgs: [progressTasks?.id]);
  }

  static Future<int> upDateisTodayBreak(
      String dateProgress, String newisTodayBreak) async {
    print('upDate Progress isTodayBreak is called');
    return await _db!.rawUpdate('''
    UPDATE $_tableProgress
    SET isTodayBreak = ?
    WHERE dateProgress = ?
 

    ''', [newisTodayBreak, dateProgress]);
  }

  static Future<int> upDateProgress(
      String dateProgress, double newValue) async {
    print('upDate Progress is called');
    return await _db!.rawUpdate('''
    UPDATE $_tableProgress
    SET progressOfDay = ?
    WHERE dateProgress = ?
 

    ''', [newValue, dateProgress]);
  }

  static Future<List<Map<String, dynamic>>> queryyProgress() async {
    // تستفر عن وجود هذه البيانات  في الداتا بيس
    // print('Queryy is called');
    return await _db!.query(_tableProgress);
  }
}
