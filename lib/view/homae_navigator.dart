import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';
import '../controller/prov_edit_task.dart';
import '../controller/theme_provider.dart';
import '../core/app_color.dart';
import '../core/mdia_qry.dart';
import '../model/progress_model.dart';
import '../model/task_uncomp.dart';
import '../view/edit_task_screen.dart';
import '../widget/theme.dart';

import '../core/method.dart';
import '../controller/prov_homepage.dart';
import '../main.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  bool currentTheme = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
// your code goes here
      var checkChange = changeValueSwitchProg(context);
      context.read<HomeProvider>().changeIsTodayBreak(checkChange);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provLang = context.read<ProvLanguge>();
    // print('Ali');
    var checkDateTaskSign = checkDateTask(context);
    var showTasktodayUnfinshed = _showtaskTodayUnfinshedDone(context);
    var showtaskCompleted = _showtaskCompleted(context);
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;

    return Directionality(
      textDirection:
          provLang.isEn ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,

          // systemStatusBarContrastEnforced: false,

          statusBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.minColor
              // const Color(0xffF9FFFF)
              : const Color(0xff22262f),
          resizeToAvoidBottomInset: false,
          floatingActionButton: floatinButton(),
          body: SafeArea(
            child: Container(
                // HHHHHHHHHHHHHHHHHHHHHHH HEIGHT
                height: medQryHeight,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 197, 233, 233)
                    : const Color(0xff424F64),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: medQryHeight * 0.2,
                            // HHHHHHHHHHHHHHHHHHHHHH HEIGHT  23
                            width: medQryWidth,

                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColor.minColor
                                  : const Color(0xff22262f),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(36.r),
                                  bottomRight: Radius.circular(36.r)),
                              // border: Border.all(color: ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1.r,
                                  blurRadius: 7.r,
                                  offset: Offset(
                                      0,
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? 3
                                          : -1), // changes position of shadow
                                ),
                              ],
                            ),

                            // ################# SIZE ONE 0.065 #################
                          ),
                          Padding(
                            child: showCalenderBar(context),
                            padding: EdgeInsets.only(
                                left: medQryWidth * 0.03,
                                right: medQryWidth * 0.03),
                          ),
                          Positioned(
                            bottom: medQryHeight * 0.063,
                            left: 0,
                            right: 0,
                            child: Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: medQryWidth * 0.015,
                                  right: medQryWidth * 0.015,
                                  top: medQryHeight * 0.022),
                              height: medQryHeight * 0.07,
                              // HHHHHHHHHHHHHHHHHHHH HIEGHT 7
                              child: LinearPercentIndicator(
                                barRadius: Radius.circular(15.r),
                                // HHHHHHHHHHHHHHHHHHHH HIEGHT 2
                                lineHeight: medQryWidth * 0.2,
                                restartAnimation: false,
                                center: FittedBox(
                                  child: Text(
                                    '${((stringProgress(context, false) ?? 0) * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                ),
                                animateFromLastPercent: true,
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : const Color(0xff424F64),
                                progressColor:
                                    //  Colors.green,
                                    (stringProgress(context, false) ?? 0) > 0.70
                                        ? ((stringProgress(context, false) ??
                                                    0) >
                                                0.80
                                            ? Colors.greenAccent.shade400
                                            : const Color.fromARGB(
                                                255, 245, 229, 13))
                                        : ((stringProgress(context, false) ??
                                                    0) >=
                                                0.50
                                            ? Colors.orange
                                            : Colors.red),
                                percent: stringProgress(context, false) ?? 0,
                                animation: true,
                                isRTL: provLang.isEn ? false : true,
                                animationDuration: 3500,
                              ),
                            ),
                          )
                        ],
                      ),
                      checkDateTaskSign
                          ? SizedBox(
                              height: medQryHeight * 0.8,
                              // HHHHHHHHHHHHHHHH HEIGHT 80
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: medQryHeight * 0.02),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      showTasktodayUnfinshed == 1
                                          ? buildDivisionTask(
                                              provLang.getText('today_task') ??
                                                  '',
                                              context)
                                          : showTasktodayUnfinshed == 3
                                              ? buildDivisionTask(
                                                  provLang.getText(
                                                          'task_unfinished') ??
                                                      '',
                                                  context)
                                              : Container(),
                                      showTasktodayUnfinshed != 3 &&
                                              showTasktodayUnfinshed != 1
                                          ? SizedBox(height: 0.h)
                                          : SizedBox(
                                              height: medQryHeight * 0.01),

                                      lstTask(context, true),
                                      // ),
                                      SizedBox(height: medQryHeight * 0.01),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: medQryWidth * 0.03,
                                            // HHHHHHHHHHHHHHH HEIGHT
                                            right: medQryWidth * 0.03),
                                        child: showtaskCompleted
                                            ? FittedBox(
                                                child: Text(
                                                  provLang.getText(
                                                          'task_completed') ??
                                                      '',
                                                  style: subHeadingStyle,
                                                ),
                                              )
                                            : Container(),
                                      ),
                                      SizedBox(height: medQryHeight * 0.01),
                                      lstTask(context, false),
                                      SizedBox(height: medQryHeight * 0.2),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: medQryHeight,
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                        width: medQryWidth * 0.9,
                                        height: medQryHeight * 0.5,
                                        margin: EdgeInsets.only(top: 100.h),
                                        child: Image.asset(
                                            'asset/images/task.png')),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  showCalenderBar(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    var provHomeWatch = context.watch<HomeProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onLongPress: () {
            context
                .read<HomeProvider>()
                .changeShowTasksHomeCalenderEditScreen(false);
          },
          onTap: () async {
            try {
              // showDialogCalender(context);
              await showDatePicker(
                      context: context,
                      currentDate: context.read<HomeProvider>().dateeOutFormat,
                      initialDate: context.read<HomeProvider>().dateeOutFormat,
                      firstDate: DateTime(2000),
                      initialDatePickerMode: DatePickerMode.day,
                      // initialEntryMode: DatePickerEntryMode.input,
                      // locale: Locale('ar', 'SA'),
                      lastDate: DateTime(2300))
                  .then((value) {
                context
                    .read<EditTaskProvider>()
                    .dateOutFormatEditSet(value ?? DateTime.now());

                return context
                    .read<HomeProvider>()
                    .changeDate(value ?? DateTime.now());
              });
              // ignore: use_build_context_synchronously
              var checkChange = changeValueSwitchProg(context);
              // ignore: use_build_context_synchronously
              context.read<HomeProvider>().changeIsTodayBreak(checkChange);
            } catch (e) {
              showToastMessageAbimation(
                  context: context, textToast: 'Error is $e');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  provLang.isEn
                      ? '${provHomeWatch.dateeOutFormat.month}/${provHomeWatch.dateeOutFormat.day}/${provHomeWatch.dateeOutFormat.year}'
                      : '${provHomeWatch.dateeOutFormat.year}/${provHomeWatch.dateeOutFormat.month}/${provHomeWatch.dateeOutFormat.day}',
                  // .
                  // Provider.of<HomeProvider>(context).dateTextWithoutDayname,
                  style: headingStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            // hoverColor: Colors.amber,
            // focusColor: Colors.amber,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              // aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
              // print('Currentt Theme is $currentTheme');
              currentTheme = !currentTheme;
              // print('Currentt 2 Theme is $currentTheme');
              await context
                  .read<ThemeProviderClass>()
                  .changeTheme(currentTheme);

              if (currentThemeProv) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    // statusBarColor: Color(0xff22262f),
                    systemNavigationBarColor: Colors.white,
                    // ignore: use_build_context_synchronously
                    systemNavigationBarIconBrightness:
                        // ignore: use_build_context_synchronously
                        Theme.of(context).brightness == ui.Brightness.light
                            ? ui.Brightness.light
                            : ui.Brightness.dark));
                return;
              }
              if (!currentThemeProv) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    systemNavigationBarColor: const Color(0xff22262f),
                    // ignore: use_build_context_synchronously
                    systemNavigationBarIconBrightness:
                        Theme.of(context).brightness == ui.Brightness.light
                            ? ui.Brightness.light
                            : ui.Brightness.dark));
                return;
              }
            },
            icon: Icon(
              color: Colors.white,
              size: 30.w,
              currentThemeProv ? Icons.sunny : Icons.brightness_3_outlined,
            ))
      ],
    );
  }

  showDialogCalender(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                //  Expanded(
                //   child:
                SizedBox(
              height: 70.h,
              width: MyMediaQuery.getScreenWidth(context),
              child:
                  // Expanded(
                  //   child:
                  DatePicker(
                DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: Colors.purple,
                onDateChange: (newDate) {
                  context.read<HomeProvider>().changeDate(newDate);
                  context.watch<HomeProvider>().getTask();
                },
                dateTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                )),
                dayTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                )),
                monthTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                )),
              ),
              // ),
            ),
            // ),
          );
        });
  }

  lstTask(BuildContext context, bool uncompleteTask) {
    var provLang = context.watch<ProvLanguge>();
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;

    // var watchProvHomeNav = context.watch<HomeProvider>();
    // var readProvHomeNav = context.read<HomeProvider>();
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.read<HomeProvider>().taskList.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          var task = context.read<HomeProvider>().taskList[index];
          var readHomeProv = context.read<HomeProvider>();
          var watchHomeProv = context.watch<HomeProvider>();
          if (readHomeProv.dateeOutFormat.year.toString() ==
                  task.dateYearTask &&
              readHomeProv.dateeOutFormat.month.toString() ==
                  task.dateMonthTask &&
              readHomeProv.dateeOutFormat.day.toString() ==
                  task.dateTodayTask &&
              (uncompleteTask
                  // is task is Completed will appear with task completed and the opposite is true
                  ? task.isCompleted == 0
                  : task.isCompleted == 1)) {
            return SizedBox(
              height: medQryHeight * 0.1,
              width: medQryWidth,
              child: LayoutBuilder(builder: (context, boxConstraints) {
                double localHeigh = boxConstraints.maxHeight;
                double localWidth = boxConstraints.maxWidth;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: localHeigh * 0.01),
                      child: GestureDetector(
                        onTap: () {
                          try {
                            context.read<EditTaskProvider>().dateeTextEditSet(
                                task.dateYearTask,
                                task.dateMonthTask,
                                task.dateTodayTask);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditTask(
                                          dateTaskYear: task.dateYearTask ?? '',
                                          dateTaskMonth:
                                              task.dateMonthTask ?? '',
                                          dateTaskToday:
                                              task.dateTodayTask ?? '',
                                          taskAchive: task.achivement ?? '',
                                          taskText: task.task ?? '',
                                          id: task.id ?? 0,
                                          deleteTask: task,
                                          isComplated: task.isCompleted ?? 0,
                                        )));
                          } catch (e) {
                            showToastMessageAbimation(
                                context: context, textToast: 'Error is $e');
                          }
                        },
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  autoClose: true,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(5.r)),
                                  onPressed: (context) async {
                                    try {
                                      if (context
                                                  .read<HomeProvider>()
                                                  .dateeOutFormat
                                                  .year ==
                                              DateTime.now().year &&
                                          context
                                                  .read<HomeProvider>()
                                                  .dateeOutFormat
                                                  .month ==
                                              DateTime.now().month &&
                                          (context
                                                  .read<HomeProvider>()
                                                  .dateeOutFormat
                                                  .day >=
                                              DateTime.now().day)) {
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .deleteTask(task);

                                        // deleteProgressProvide(context);

                                        if (task.isCompleted == 1) {
                                          sumAndMinusProgress(
                                              context, false, task.achivement);
                                        }
                                      } else {
                                        showToastMessageAbimation(
                                            context: context,
                                            textToast: provLang.getText(
                                                'you_cant_delete_past'));
                                      }
                                    } catch (e) {
                                      showToastMessageAbimation(
                                          context: context,
                                          textToast: 'Error is $e');
                                    }
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  icon: Icons.delete,
                                  label:
                                      provLang.getText('delete_btn_edit_task'),
                                ),
                              ]),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: localWidth * 0.02,
                                bottom: localWidth * 0.02),
                            // height: 65.h,
                            width: localWidth * 0.95,
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
                              minLeadingWidth: localWidth * 0.0,
                              trailing: Padding(
                                padding: EdgeInsets.only(
                                  top: localHeigh * 0.02,
                                  bottom: localHeigh * 0.02,
                                  left: localWidth * 0.02,
                                  right: localWidth * 0.02,
                                ),
                                child: FittedBox(
                                  child: Text(
                                    task.achivement!,
                                    // '${double.parse(task.achivement!).toStringAsFixed(0)} %',
                                    style: subHeadingStyle.copyWith(
                                        color: const Color.fromARGB(
                                            255, 44, 43, 43)),
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                right: localWidth * 0.02,
                                left: localWidth * 0.02,
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(
                                  right: localWidth * 0.01,
                                ),
                                // child: FittedBox(
                                child: Text(
                                    watchHomeProv
                                            .showTasksHomeCalenderEditScreen
                                        ? '${task.task}'
                                        : '******',
                                    overflow: TextOverflow.ellipsis,
                                    style: subHeadingStyle.copyWith(
                                        // decoration: TextDecoration.lineThrough,
                                        color: const Color.fromARGB(
                                            255, 44, 43, 43))),
                                // ),
                              ),
                              horizontalTitleGap: localWidth * 0.001,
                              leading: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    checkColor: task.isCompleted == 0
                                        ? (readHomeProv.dateeOutFormat.year ==
                                                    DateTime.now().year &&
                                                readHomeProv
                                                        .dateeOutFormat.month ==
                                                    DateTime.now().month &&
                                                readHomeProv
                                                        .dateeOutFormat.day >
                                                    DateTime.now().day
                                            ? Colors.amber
                                            : Colors.red)
                                        : Colors.white,
                                    activeColor: readHomeProv.dateeText ==
                                            DateFormat.yMEd()
                                                .format(DateTime.now())
                                        ? const Color.fromARGB(
                                            243, 157, 245, 69)
                                        : (task.isCompleted == 1
                                            ? const Color.fromARGB(
                                                243, 157, 245, 69)
                                            : (readHomeProv.dateeOutFormat
                                                            .year ==
                                                        DateTime.now().year &&
                                                    readHomeProv.dateeOutFormat
                                                            .month ==
                                                        DateTime.now().month &&
                                                    readHomeProv.dateeOutFormat
                                                            .day >
                                                        DateTime.now().day
                                                ? Colors.amber
                                                : Colors.red)),
                                    // const Color.fromARGB(255, 52, 250, 62),
                                    shape: const CircleBorder(),
                                    onChanged: (valee) async {
                                      if (context
                                              .read<HomeProvider>()
                                              .dateeText ==
                                          DateFormat.yMEd()
                                              .format(DateTime.now())) {
                                        var provHomeRead =
                                            context.read<HomeProvider>();
                                        if (valee ?? false) {
                                          checkDateProgress(
                                              context,
                                              double.parse(
                                                  task.achivement.toString()));
                                          bool checkDateProg =
                                              checkDateProgress(
                                                  context,
                                                  double.parse(task.achivement
                                                      .toString()));
                                          // print('Check prog $checkDateProg');
                                          // print(
                                          //     'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
                                          if (provHomeRead
                                                  .progressList.isEmpty ||
                                              checkDateProg) {}
                                        }

                                        provHomeRead.changeCheckBox(
                                            valee!, task.id!);

                                        if (valee) {
                                          sumAndMinusProgress(
                                              context, valee, task.achivement);
                                        }
                                        if (!valee) {
                                          sumAndMinusProgress(
                                              context, valee, task.achivement);
                                        }
                                      }
                                    },

                                    value: context
                                                .watch<HomeProvider>()
                                                .dateeText ==
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
              }),
            );
          } else {
            return Container(
              color: Colors.amber[600],
            );
          }
        });
    //       }),
    // );
    // ])
  }

  floatinButton() {
    return FloatingActionButton(
      // backgroundColor: Colors.red,
      child: const Icon(Icons.add_outlined),

      onPressed: () {
        try {
          var provLang = context.read<ProvLanguge>();
          var proveHome = context.read<HomeProvider>();
          if (proveHome.isTodayBreakProv) {
            showToastMessageAbimation(
                context: context,
                textToast: provLang.getText('cant_add_when_break'));
            return;
          }

          final dateprov = context.read<HomeProvider>().dateeOutFormat;
          final datenow = DateTime.now();
          if (dateprov.year == datenow.year &&
              dateprov.month == datenow.month &&
              (dateprov.day >= datenow.day)) {
            insertProgressOfDayTasks(context: context);

            // var vale = checkDateTask(context);
            // print('Vale of False or True is $vale');
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r))),
              context: context,
              builder: (buil) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4 + 255,
                  child: const ShowBottomSheet()),
            );
          } else {
            showToastMessageAbimation(
                context: context,
                textToast: provLang.getText('day_already_past'));
            return;
          }
        } catch (e) {
          showToastMessageAbimation(context: context, textToast: 'Error is $e');
        }
      },
    );
  }

  bool checkDateTask(BuildContext context) {
    var readHomeProv = context.read<HomeProvider>();
    int i = 0;
    while (i < context.read<HomeProvider>().taskList.length) {
      if (readHomeProv.dateeOutFormat.year.toString() ==
              readHomeProv.taskList[i].dateYearTask &&
          readHomeProv.dateeOutFormat.month.toString() ==
              readHomeProv.taskList[i].dateMonthTask &&
          readHomeProv.dateeOutFormat.day.toString() ==
              readHomeProv.taskList[i].dateTodayTask) {
        return true;
      }
      i++;
    }
    return false;
  }

  deleteProgressProvide(BuildContext context) async {
    // print('DELETE PROGRESS CALLED');
    // print('GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG');
    int i = 0;
    int x = 1;
    int pr = 0;
    var read = context.read<HomeProvider>();
    while (i < read.taskList.length) {
      // print('Inside WHILE LOOP OF TASKLIST LENGTH is ${read.taskList.length}');
      // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
      if (read.taskList.isEmpty ||
          (read.dateeOutFormat.year.toString() ==
                  read.taskList[i].dateYearTask &&
              read.dateeOutFormat.month.toString() ==
                  read.taskList[i].dateMonthTask &&
              read.dateeOutFormat.day.toString() !=
                  read.taskList[i].dateTodayTask)) {
        // print('Inside IF  OF X');
        // print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');

        // print('Inside IF  OF read.taskList.length ${read.taskList.length}');
        // print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        ++x;
        // print('Inside IF  OF X $x');
      }
      if (read.taskList.isEmpty || x == read.taskList.length) {
        while (pr < read.progressList.length) {
          if (read.progressList[pr].dateProgressYear ==
                  read.dateeOutFormat.year.toString() &&
              read.progressList[pr].dateProgressmonth ==
                  read.dateeOutFormat.month.toString() &&
              read.progressList[pr].dateProgressToday ==
                  read.dateeOutFormat.day.toString()) {
            // print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
            // print('before deleted');
            read.deleteProgress(read.progressList[pr]);
            // print('has deleted ${read.progressList[pr]}');
            // // read.getProgress();
            // print('++++++++++++ffffffffffffffffffffffffff');
          }
          pr++;
        }
      }
      i++;
    }
  }

  _showtaskTodayUnfinshedDone(BuildContext context) {
    int i = 0;
    int disapTod = 0;
    var readProv = context.read<HomeProvider>();
    var dateFormatNow = DateFormat.yMEd().format(DateTime.now());
    while (i < context.read<HomeProvider>().taskList.length) {
      if (readProv.dateeText == dateFormatNow &&
          readProv.taskList[i].isCompleted == 0 &&
          (readProv.dateeOutFormat.year.toString() ==
                  readProv.taskList[i].dateYearTask &&
              readProv.dateeOutFormat.month.toString() ==
                  readProv.taskList[i].dateMonthTask &&
              readProv.dateeOutFormat.day.toString() ==
                  readProv.taskList[i].dateTodayTask)) {
        // print('Show unShow Task Today Method is 1');
        return 1;
      }
      if (readProv.dateeText == dateFormatNow &&
          readProv.taskList[i].isCompleted == 1 &&
          (readProv.dateeOutFormat.year.toString() ==
                  readProv.taskList[i].dateYearTask &&
              readProv.dateeOutFormat.month.toString() ==
                  readProv.taskList[i].dateMonthTask &&
              readProv.dateeOutFormat.day.toString() ==
                  readProv.taskList[i].dateTodayTask)) {
        if (disapTod == readProv.taskList.length) {
          // print('Show unShow Task Today Method is 2');
          // print('Length of disTod is $disapTod');
          return 2;
        }
      }
      if (readProv.dateeText != dateFormatNow &&
          readProv.taskList[i].isCompleted == 0 &&
          (readProv.dateeOutFormat.year.toString() ==
                  readProv.taskList[i].dateYearTask &&
              readProv.dateeOutFormat.month.toString() ==
                  readProv.taskList[i].dateMonthTask &&
              readProv.dateeOutFormat.day.toString() ==
                  readProv.taskList[i].dateTodayTask)) {
        // print('Show unShow Task Today Method is 3');
        return 3;
      }

      i++;
    }
    return 0;
  }

  bool _showtaskCompleted(BuildContext context) {
    int i = 0;
    while (i < context.read<HomeProvider>().taskList.length) {
      if (context.read<HomeProvider>().dateeText ==
              DateFormat.yMEd().format(DateTime.now()) &&
          context.read<HomeProvider>().taskList[i].isCompleted == 1 &&
          (context.read<HomeProvider>().dateeOutFormat.year.toString() ==
                  context.read<HomeProvider>().taskList[i].dateYearTask &&
              context.read<HomeProvider>().dateeOutFormat.month.toString() ==
                  context.read<HomeProvider>().taskList[i].dateMonthTask &&
              context.read<HomeProvider>().dateeOutFormat.day.toString() ==
                  context.read<HomeProvider>().taskList[i].dateTodayTask)) {
        return true;
      }
      if (context.read<HomeProvider>().dateeText !=
              DateFormat.yMEd().format(DateTime.now()) &&
          context.read<HomeProvider>().taskList[i].isCompleted == 1 &&
          (context.read<HomeProvider>().dateeOutFormat.year.toString() ==
                  context.read<HomeProvider>().taskList[i].dateYearTask &&
              context.read<HomeProvider>().dateeOutFormat.month.toString() ==
                  context.read<HomeProvider>().taskList[i].dateMonthTask &&
              context.read<HomeProvider>().dateeOutFormat.day.toString() ==
                  context.read<HomeProvider>().taskList[i].dateTodayTask)) {
        return true;
      }

      i++;
    }
    return false;
  }

  Future<void> insertProgressHome(BuildContext context) async {
    // print('+++++++++++++++++++++++++++++++++++++++++++++++');
    // print('Now we add new Progress');
    // print('+++++++++++++++++++++++++++++++++++++++++++++++');
    try {
      // print('PROGRES IIIIIIIIIIII ${context.read<HomeProvider>().progres}');
      await context.read<HomeProvider>().addProgress(
              progressTasks: ProgressTasks(
            dateProgress: context.read<HomeProvider>().dateeText,
            dateProgressYear:
                context.read<HomeProvider>().dateeOutFormat.year.toString(),
            dateProgressmonth:
                context.read<HomeProvider>().dateeOutFormat.month.toString(),
            dateProgressToday:
                context.read<HomeProvider>().dateeOutFormat.day.toString(),
            progressOfDay: context.read<HomeProvider>().progres,
            isTodayBreak: '',
          ));
      // return;
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
      // print('Proplem of Progress is $e');
    }
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

  stringProgress(BuildContext context, bool isID) {
    var provRead = context.read<HomeProvider>();
    for (int i = 0; i < provRead.progressList.length; i++) {
      if (provRead.progressList[i].dateProgressYear ==
              provRead.dateeOutFormat.year.toString() &&
          provRead.progressList[i].dateProgressmonth ==
              provRead.dateeOutFormat.month.toString() &&
          provRead.progressList[i].dateProgressToday ==
              provRead.dateeOutFormat.day.toString()) {
        if (!isID) {
          return provRead.progressList[i].progressOfDay;
        }
        if (isID) {
          return provRead.progressList[i].id;
        }
      }
    }
  }

  bool changeValueSwitchProg(BuildContext context) {
    try {
      var provHome = context.read<HomeProvider>();

      int i = 0;
      if (provHome.progressList.isNotEmpty) {
        while (i < provHome.progressList.length) {
          if (provHome.dateeOutFormat.year.toString() ==
                  provHome.progressList[i].dateProgressYear &&
              provHome.dateeOutFormat.month.toString() ==
                  provHome.progressList[i].dateProgressmonth &&
              provHome.dateeOutFormat.day.toString() ==
                  provHome.progressList[i].dateProgressToday) {
            if (provHome.progressList[i].isTodayBreak ==
                'gh^%vb42TAKESBROKRESTBAFAMAMO,.><') {
              return true;
            } else {
              return false;
            }
          }
          i++;
        }
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
    return false;
  }

  buildDivisionTask(String title, BuildContext context) {
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return SizedBox(
      width: medQryWidth,
      height: medQryHeight * 0.06,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        double localHeigh = boxConstraints.maxHeight;
        double localWidth = boxConstraints.maxWidth;
        return Padding(
            padding: EdgeInsets.only(
                left: localWidth * 0.035,
                top: localHeigh * 0.1,
                bottom: localHeigh * 0.00,
                right: localWidth * 0.035),
            // ######################################################################
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  child: SizedBox(
                      // height: localHeigh * 0.1,
                      child: FittedBox(
                    child: Text(
                      title,
                      style: subHeadingStyle,
                    ),
                  )),
                ),
              ],
            ));
      }),
    );
  }
}

// Classs Bottom sheet

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  FocusNode focusNode = FocusNode();
  bool currentTheme = true;
  bool fieldOne = false;
  bool fieldTwo = false;
  // int timeleft = 10;

  late final TextEditingController controlTask;
  late final TextEditingController controlAchive;
  late final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // if (currentThemeProv) {
    //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //       // statusBarColor: Color(0xff22262f),
    //       systemNavigationBarColor: Colors.white,
    //       // ignore: use_build_context_synchronously
    //       systemNavigationBarIconBrightness: Brightness.light));
    //   // return;
    // }
    // if (!currentThemeProv) {
    //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //       systemNavigationBarColor: Color(0xff22262f),
    //       // ignore: use_build_context_synchronously
    //       systemNavigationBarIconBrightness: Brightness.dark));
    //   // return;
    // }

    // System controll
    controlAchive = TextEditingController();
    controlTask = TextEditingController();
    controlTask.addListener(() {
      final isControllTaskFieldNotEmpty = controlTask.text.isNotEmpty;
      context
          .read<HomeProvider>()
          .changeConrollerTaskActive(isControllTaskFieldNotEmpty);
    });
    controlAchive.addListener(() {
      final isControllAchiveFieldNotEmpty = controlAchive.text.isNotEmpty;
      context
          .read<HomeProvider>()
          .changeConrollerAchiveActive(isControllAchiveFieldNotEmpty);
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    controlAchive.dispose();
    controlTask.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    var provHomeWatch = context.watch<HomeProvider>();

    return Directionality(
      textDirection:
          provLang.isEn ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.h,
            right: 8.w,
            left: 8.w,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          // $$$$$$%%%%%%%%%%%%%%%%%%%%%%%#################################
          height: provLang.isEn ? 241.h : 251.h,

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  // HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Container(
                    // height: 90.h,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: TextFormField(
                        maxLength: 350,
                        maxLines: 1,
                        minLines: 1,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        autofocus: true,
                        controller: controlTask,
                        focusNode: focusNode,
                        style: subHeadingStyle.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            hintStyle: subHeadingStyle.copyWith(
                                color: Colors.grey[700]),
                            hintText: provLang.getText('write_new_task') ?? '',
                            contentPadding:
                                EdgeInsets.only(top: 30.h, bottom: 30.h),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7.w, right: 7.h, top: 7.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: TextFormField(
                        maxLines: 1,
                        maxLength: 3,
                        expands: false,
                        // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: subHeadingStyle.copyWith(
                            color: const Color.fromARGB(255, 44, 43, 43),
                            fontWeight: FontWeight.w300),
                        keyboardType: TextInputType.number,
                        controller: controlAchive,
                        decoration: InputDecoration(
                            hintStyle: subHeadingStyle.copyWith(
                                color: Colors.grey[700], fontSize: 15.sp),
                            hintText:
                                provLang.getText('write_percent_task') ?? '',
                            contentPadding: EdgeInsets.only(
                              top: 20.h,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: provHomeWatch.isControllerTaskActive &&
                                provHomeWatch.isControllerAchiveActive
                            ? () async {
                                try {
                                  var proveHome = context.read<HomeProvider>();
                                  if (_formKey.currentState!.validate()) {
                                    final dateprov =
                                        context.read<HomeProvider>().dateeText;
                                    final datenow = DateFormat.yMEd()
                                        .format(DateTime.now());
                                    if (dateprov.compareTo(datenow) > 0) {
                                      // print(
                                      //     "######################################################");
                                      // print(
                                      //     "DateSelected is after DateTime now");
                                      // print(
                                      //     "######################################################");
                                    }

                                    var totalPercent =
                                        isProgresMaximum(context: context);
                                    totalPercent += double.parse(
                                        controlAchive.text.toString());
                                    // print('totalPercent is $totalPercent');
                                    // print(
                                    //     'SUMSUMSUSMSUSMUSMUSMUSSUMSMSUMSUMSUMSUMSUMSUM');
                                    // print(
                                    //     'SUMSUMSUSMSUSMUSMUSMUSSUMSMSUMSUMSUMSUMSUMSUM');
                                    try {
                                      if (totalPercent > 100) {
                                        // print(
                                        //     'you reached the maximum perscent decresce or delete some task');
                                        showToastMessageAbimation(
                                            context: context,
                                            textToast:
                                                '${provLang.getText('total_percent_part_one')} $totalPercent ${provLang.getText('total_percent_part_two')}');
                                      } else {
                                        await context
                                            .read<HomeProvider>()
                                            .addTask(
                                                task: DoTask(
                                              dateYearTask: proveHome
                                                  .dateeOutFormat.year
                                                  .toString(),
                                              dateMonthTask: proveHome
                                                  .dateeOutFormat.month
                                                  .toString(),
                                              dateTodayTask: proveHome
                                                  .dateeOutFormat.day
                                                  .toString(),
                                              achivement:
                                                  controlAchive.text.toString(),
                                              task: controlTask.text.toString(),
                                              isCompleted:
                                                  proveHome.isCompleted = 0,
                                            ));

                                        controlTask.clear();
                                        controlAchive.clear();
                                      }
                                    } catch (e) {
                                      showToastMessageAbimation(
                                          context: context,
                                          textToast: 'Error is $e');
                                    }
                                  }
                                  // ignore: use_build_context_synchronously
                                  await context.read<HomeProvider>().getTask();
                                  // ignore: use_build_context_synchronously

                                  // print(
                                  //     // ignore: use_build_context_synchronously
                                  //     'Taks List length is ${context.read<HomeProvider>().taskList.length}');
                                } catch (e) {
                                  showToastMessageAbimation(
                                      context: context,
                                      textToast: 'Error is $e');
                                }
                              }
                            : null,
                        icon: Container(
                          width: 50.w,
                          height: 50.h,

                          decoration: BoxDecoration(
                            color: provHomeWatch.isControllerTaskActive &&
                                    provHomeWatch.isControllerAchiveActive
                                ? AppColor.minColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          // color: AppColor.minColor,
                          child: const Icon(
                            Icons.navigation_outlined,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
          // ),
          // ),
        ),
      ),
    );
  }
}
