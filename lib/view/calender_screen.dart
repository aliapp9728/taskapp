import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskjob_aliapp/controller/prov_calendar.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';

import '../controller/prov_homepage.dart';
import '../widget/theme.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provCalendarWatch = context.watch<ProvCalendar>();
    var provCalendarRead = context.read<ProvCalendar>();
    var provLang = context.watch<ProvLanguge>();
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    var textStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp);
    return Directionality(
      textDirection:
          provLang.isEn ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color.fromARGB(255, 238, 247, 247)
            : const Color(0xff424F64),
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeProvider>().getProgress();
            context.read<HomeProvider>().getTask();
          },
          child: Container(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(255, 238, 247, 247)
                : const Color(0xff424F64),
            child: Column(
              children: [
                TableCalendar(
                  availableCalendarFormats: {
                    CalendarFormat.month: provLang.isEn ? 'Month' : 'شهر',
                    CalendarFormat.week: provLang.isEn ? 'Week' : 'إسبوع',
                    CalendarFormat.twoWeeks:
                        provLang.isEn ? '2Week' : 'إسبوعين',
                  },
                  locale: provLang.isEn == false ? "ar_SA" : null,
                  // weekNumbersVisible: true,
                  // daysOfWeekVisible: true,

                  formatAnimationCurve: Curves.fastOutSlowIn,
                  formatAnimationDuration: const Duration(milliseconds: 2000),
                  onHeaderTapped: (date) {
                    // print('AAAAAAAAAAAAAAAAAAAAA');
                  },
                  calendarFormat: provCalendarWatch.calendarFormat,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    formatButtonShowsNext: false,
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMMd(locale).format(date),
                    titleCentered: true,
                    titleTextStyle: textStyle,
                    formatButtonTextStyle: textStyle.copyWith(fontSize: 14.sp),
                  ),

                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: textStyle.copyWith(fontSize: 14.sp),
                      weekendStyle: textStyle.copyWith(
                          fontSize: 14.sp, color: Colors.grey.shade500)),
                  daysOfWeekHeight: medQryHeight * 0.03,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: textStyle.copyWith(fontSize: 14.sp),
                    // holidayTextStyle: textStyle.copyWith(fontSize: 16),
                    // todayDecoration: BoxDecoration(
                    //   color: Colors.amber,
                    //   shape: BoxShape.circle,
                    //   // borderRadius: BorderRadius.all(Radius.circular(50))
                    // ),

                    outsideTextStyle: textStyle.copyWith(
                        fontSize: 14.sp, color: Colors.grey.shade500),
                    weekendTextStyle: textStyle.copyWith(
                        fontSize: 14.sp, color: Colors.red.shade300),
                  ),
                  onFormatChanged: (change) {
                    if (provCalendarRead.calendarFormat ==
                        CalendarFormat.month) {
                      provCalendarRead
                          .changeCalendarFormat(CalendarFormat.twoWeeks);
                      return;
                    }
                    if (provCalendarRead.calendarFormat ==
                        CalendarFormat.twoWeeks) {
                      provCalendarRead
                          .changeCalendarFormat(CalendarFormat.week);
                      return;
                    }
                    if (provCalendarRead.calendarFormat ==
                        CalendarFormat.week) {
                      provCalendarRead
                          .changeCalendarFormat(CalendarFormat.month);
                      return;
                    }
                  },
                  weekendDays: const [DateTime.friday, DateTime.saturday],
                  firstDay: DateTime(2003, 3, 23),
                  lastDay: DateTime(2050, 12, 30),
                  focusedDay: provCalendarWatch.currentDate,
                  currentDay: provCalendarWatch.currentDate,
                  onDaySelected: (datone, dateTwo) {
                    // print(' ddddddddddddddddDDDDDDDDDDDDDDDDDDDDDDD');
                    // print(' datone $datone');
                    // print(' dateTwo $dateTwo');
                    provCalendarRead.changeCurrentDate(dateTwo);
                    provCalendarRead.changeDateTextCalender(dateTwo);
                    // print(' ddddddddddddddddDDDDDDDDDDDDDDDDDDDDDDD');
                  },
                ),
                SizedBox(
                  height: medQryHeight * 0.03,
                ),
                lstTask(context, true)
              ],
            ),
          ),
        )),
      ),
    );
  }

  lstTask(BuildContext context, bool uncompleteTask) {
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: context.read<HomeProvider>().taskList.length,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            var task = context.read<HomeProvider>().taskList[index];
            var readProvCalender = context.read<ProvCalendar>();
            var watchHomeProvider = context.watch<HomeProvider>();
            if (readProvCalender.currentDate.year.toString() ==
                    task.dateYearTask &&
                readProvCalender.currentDate.month.toString() ==
                    task.dateMonthTask &&
                readProvCalender.currentDate.day.toString() ==
                    task.dateTodayTask) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.h),
                    child: GestureDetector(
                      onTap: () {},
                      child: Slidable(
                        startActionPane:
                            // ignore: prefer_const_constructors
                            ActionPane(
                                motion: const ScrollMotion(),
                                children: const []),
                        child: Container(
                          padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
                          height: medQryHeight * 0.1,
                          width: medQryWidth * 0.93,
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[200]
                                  : const Color(0xff99c8cd),
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(6.r),
                                left: Radius.circular(6.r),
                              )),
                          child: ListTile(
                            // minLeadingWidth: medQryWidth * 0.1,
                            trailing: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.h, bottom: 8.h, left: 8.w, right: 8.w),
                              child: SizedBox(
                                width: medQryWidth * 0.1,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    task.achivement!,
                                    style: subHeadingStyle.copyWith(
                                        color: const Color.fromARGB(
                                            255, 44, 43, 43)),
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(right: 10.w),
                            title: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              // child: FittedBox(
                              child: Text(
                                  watchHomeProvider
                                          .showTasksHomeCalenderEditScreen
                                      ? '${task.task}'
                                      : '******',
                                  overflow: TextOverflow.ellipsis,
                                  style: subHeadingStyle.copyWith(
                                      color: const Color.fromARGB(
                                          255, 44, 43, 43))),
                            ),
                            // ),
                            horizontalTitleGap: 5,
                            leading: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  checkColor: task.isCompleted == 0
                                      ? Colors.red
                                      : Colors.white,
                                  activeColor: readProvCalender
                                              .dateTextCalender ==
                                          DateFormat.yMEd()
                                              .format(DateTime.now())
                                      ? const Color.fromARGB(243, 157, 245, 69)
                                      : (task.isCompleted == 1
                                          ? const Color.fromARGB(
                                              243, 157, 245, 69)
                                          : Colors.red),
                                  // const Color.fromARGB(255, 52, 250, 62),
                                  shape: const CircleBorder(),
                                  onChanged: (valee) async {},
                                  value: readProvCalender.dateTextCalender ==
                                          DateFormat.yMEd()
                                              .format(DateTime.now())
                                      ? (task.isCompleted == 1 ? true : false)
                                      : true,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                color: Colors.amber[600],
              );
            }
          }),
    );
    //       }),
    // );
    // ])
  }

  // to check if Progresslist has dateTime of now or not
  bool checkDateProgress(BuildContext context, double value) {
    var prov = context.read<HomeProvider>();
    DateTime dateNow = DateTime.now();
    int i = 0;
    // for (; ++i)
    while (i < prov.progressList.length) {
      if (prov.progressList[i].dateProgressYear == dateNow.year.toString() &&
          prov.progressList[i].dateProgressmonth == dateNow.month.toString() &&
          prov.progressList[i].dateProgressToday != dateNow.day.toString()) {
        // To check if there is no PROGRESS for Today
        if (prov.progressList.length - i == 1) {
          prov.progres = value * 0.01;
          return true;
        }
      }
      ++i;
    }
    return false;
  }
}
