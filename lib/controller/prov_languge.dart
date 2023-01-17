import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvLanguge extends ChangeNotifier {
  bool _isEn = true;
  bool get isEn => _isEn;
  Map<String, Object> textEn = {
    // Home Screen
    'today_task': 'Today`s Task',
    'task_unfinished': ' Task Unfinished',
    'task_completed': 'Task Completed',
    'write_new_task': 'Writer new task',
    'write_percent_task': 'Writer the percent of  task',

    // Drawer Head
    'user_name': 'Guest',

    // Drawer Body
    'take_break': 'Take Today Break',
    'lan_eng': 'Language English',
    'lan_arab': 'اللغة العربية',
    // Drawer achievement
    'achievement_report': 'Achievement Reports',
    'half_month_report': 'Half-monthly Report',
    'month_report': 'Monthly Report',
    'yearly_report': 'Yearly Report',
    // Drawer Tasks
    'all_task': 'All Tasks & Achievements',
    'completed_task': 'Completet Tasks',
    'task_unfifnshed': 'Unfinished Tasks',
    // Drawer daily_achivement
    'daily_achivement': 'Daily Achievements',

    // Hlaf month report screen

    'title_halfMonth_report': 'First Half-month',
    'change_date': 'Change Date',
    'ahievement_half_month': 'Achievement of First Half is :',
    'days_achive_90_100': 'The Days  achievment 90-100% is : ',
    'days_achive_70_90': 'The Days  achievment 70-90% is : ',
    'days_achive_50_70': 'The Days  achievment 50-70% is : ',
    'days_achive_less50': 'The Days  achievment less than 50% is : ',
    'days_take_rest': 'The Days  you taked rest is : ',
    'there_no_data_halfMonth': 'There is no data for this month yet',
    'year_drop_halfMonth': 'year : ',
    'month_drop_halfMonth': 'Month : ',
    'lis_prog_take_rest': 'You took this day off',
    'lis_prog_date_halfMonth': 'Date : ',

    // Month report screen

    'title_Month_report': 'Achievement of month ',
    'ahievement_month': 'Achievement of this Month is :',

    // Yearly report screen

    'title_yearly_report': 'Achivement of year',
    'change_date_year': 'Change Year',
    'ahievement_year': 'Achievement of this Year is : ',
    'month_achive_90_100': 'The Months  achievment 90-100% is : ',
    'month_achive_70_90': 'The Months  achievment 70-90% is : ',
    'month_achive_50_70': 'The Months  achievment 50-70% is : ',
    'months_achive_less50': 'The Months  achievment less than 50% is : ',
    'there_no_data_year': 'There is no data for this Year yet',
    'lis_prog_date_year': 'Month number : ',

    // Completed Task Screen
    'title_completed_tasks': 'Completed Tasks',
    // Completed Task Screen
    'title_unCompleted_tasks': 'UnCompleted Tasks',
    // Achiviement of days Screen
    'title_acheivement_days': 'Achievement of Days',

    // Toast Message Animation

    // Toast Home Navigator

    'you_cant_delete_past': 'You can`t delete it because it becomes past ',
    // 'total_percen_more_100decrese_part_one':
    //     'you can`t edit the percentage , due Total of percentage is ',
    // 'total_percen_more_100decrese_part_two':
    //     ' more than 100  Decrease the percentage of other tasks  Or delete unNecessary tasks',
    'cant_add_when_break': 'You cant add task when you take a break',
    'day_already_past': 'This day already has passed',

    //  Toast Drawer
    'should_delete_task_toTake_break':
        'You should delete the tasks first to take today break',
    //  Toast Edit Task
    'total_percent_part_one': 'Total of percentage is ',
    'total_percent_part_two':
        ' more than 100  Decrease the percentage of other tasks  Or delete unNecessary tasks ',
    'cant_add_task_toPast': 'You can`t add Task to past',
    'task_complete_makeIt_unComplete_toChange_date':
        'Task is Completed ,Make it UnComplated to change Date',
    'date_become_past_cant_change-it':
        'The date become past ,You can`t change it',
    'date_become_past_cant_delete-it':
        'The date become past ,You can`t delete it',

    // Edit Task Screen
    'title_edit_task': 'Edit Task',
    'save_btn_edit_task': 'Save',
    'due_date_edit_task': 'Due date',
    'delete_task_edit_task': 'Delete task',
    'delete_btn_edit_task': 'Delete',
  };
  Map<String, Object> textAr = {
    // Home Screen
    'today_task': 'مهام اليوم',
    'task_unfinished': 'مهام غير منجزة',
    'task_completed': 'المهام المكتملة',
    'write_new_task': 'ادخل مهمة جديدة',
    'write_percent_task': 'ادخل عدد نقاط المهمة',

    // Drawer Head
    'user_name': 'ضيف',

    // Drawer Body
    'take_break': 'اخذ اليوم إستراحة',
    'lan_arab': 'اللغة العربية',
    'lan_eng': 'Language English',
    // Drawer achievement
    'achievement_report': 'تقارير الأنجاز',
    'half_month_report': 'تقرير نصف الشهر',
    'month_report': 'التقرير الشهري',
    'yearly_report': 'التقرير السنوي',
    // Drawer Tasks
    'all_task': 'جميع المهام والانجازات اليومية',
    'completed_task': 'المهام المكتملة',
    'task_unfifnshed': 'المهام الغير مكتملة',
    // Drawer daily_achivement
    'daily_achivement': 'الانجازات اليومية',

    // Hlaf month report screen

    'title_halfMonth_report': 'النصف الأول لشهر ',
    'change_date': 'تغيير التاريخ',
    'ahievement_half_month': 'نسبة الانجاز لنصف الشهر الاول هو : ',
    'days_achive_90_100': 'الأيام التي انجازها  90-100  هي : ',
    'days_achive_70_90': 'الأيام التي انجازها  70-90  هي : ',
    'days_achive_50_70': 'الأيام التي انجازها  50-70 هي : ',
    'days_achive_less50': 'الأيام التي انجازها اقل من  50% هي : ',
    'days_take_rest': 'عدد أيام العطل التي اخذتها هي : ',
    'there_no_data_halfMonth': 'لا يوجد بيانات كافية لهذا الشهر بعد',
    'year_drop_halfMonth': 'السنة : ',
    'month_drop_halfMonth': 'الشهر : ',
    'lis_prog_take_rest': 'لقد اخذت اليوم عطلة',
    'lis_prog_date_halfMonth': '  التاريخ : ',

    // Month report screen

    'title_Month_report': 'إنجاز شهر ',
    'ahievement_month': 'نسبة الانجاز في هذا الشهر : ',
    // Yearly report screen

    'title_yearly_report': 'إنجاز سنة',
    'change_date_year': 'تغيير السنة',
    'ahievement_year': 'نسبة الإنجاز لهذه السنة هو : ',
    'month_achive_90_100': 'الشهور التي انجازها  90-100  هي : ',
    'month_achive_70_90': 'الشهور التي انجازها  70-90  هي : ',
    'month_achive_50_70': 'الشهور التي انجازها  50-70 هي : ',
    'months_achive_less50': 'الشهور التي انجازها اقل من  50% هي : ',
    'there_no_data_year': 'لا يوجد معلومات كافية لهذه السنة بعد',
    'lis_prog_date_year': '  رقم الشهر : ',

    // Completed Task Screen
    'title_completed_tasks': 'المهام المكتملة',
    // Completed Task Screen
    'title_unCompleted_tasks': 'المهام الغير منجزة',
    // Achiviement of days Screen
    'title_acheivement_days': 'نسبة الأنجاز للأيام',

    // Toast Message Animation

    // Toast Home Navigator

    'you_cant_delete_past': 'لا يمكنك حذفها لأن تاريخها مضى   ',
    // 'total_percen_more_100decrese_part_one':
    //     'لا يمكن حفظ الرقم الحالي حيث المجموع الكلي',
    // 'total_percen_more_100decrese_part_two':
    //     'المجموع اكثر من 100 قلل عدد نقاط المهام الاخرى او إحذف المهام الغير ضرورية',
    'cant_add_when_break': 'لا يمكن إضافة مهام في حالة اخذ اليوم عطلة',
    'day_already_past': 'تاريخ هذا اليوم مضى',

    //  Toast Drawer
    'should_delete_task_toTake_break':
        'يجب حذف المهام اولا لكي تأخذ اليوم عطلة',
    //  Toast Edit Task
    'total_percent_part_one': 'مجموع النقاط هو ',
    'total_percent_part_two':
        'اكثر من 100 , قلل نقاط المهام الاخرى او احذف المهام الغير ضرورية',
    'cant_add_task_toPast': 'لا يمكنك اضافة مهمة الى الماضي ',
    'task_complete_makeIt_unComplete_toChange_date':
        'المهمة مكتملة , اجعلها غير مكتملة لتغير تاريخها',
    'date_become_past_cant_change-it': 'التاريخ قد مضى , لا يمكنك تغييرها',
    'date_become_past_cant_delete-it': 'التاريخ قد مضى , لا يمكنك حذفها',

    // Edit Task Screen
    'title_edit_task': 'تعديل المهمة',
    'save_btn_edit_task': 'حفظ',
    'due_date_edit_task': 'تاريخ الأستحقاق',
    'delete_task_edit_task': 'حذف المهمة',
    'delete_btn_edit_task': 'حذف',
  };

  Future<void> changeLanguage(bool newValue) async {
    _isEn = newValue;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lang', newValue);
    notifyListeners();
  }

  getText(String text) {
    if (_isEn) {
      return textEn[text].toString();
    }
    if (!_isEn) {
      return textAr[text].toString();
    }
    notifyListeners();
  }
}
