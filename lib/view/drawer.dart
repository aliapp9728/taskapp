import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/prov_homepage.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';
import 'package:taskjob_aliapp/view/drawer_screen/ahicve_half_month_screen.dart';
import 'package:taskjob_aliapp/view/drawer_screen/ahicve_month_screen.dart';
import 'package:taskjob_aliapp/view/drawer_screen/complete_tasks.dart';

import '../core/app_color.dart';
import '../core/mdia_qry.dart';
import '../core/method.dart';
import 'drawer_screen/all_achievment.dart';
import 'drawer_screen/uncompleted_task.dart';
import 'drawer_screen/year_achive_report_screen.dart';

class DrawePage extends StatelessWidget {
  const DrawePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;

    var provLang = context.watch<ProvLanguge>();
    return SafeArea(
      top: false,
      child: Drawer(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? AppColor.minColor
            : const Color(0xff22262f),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: medQryHeight * 0.05,
              //  Adapt.screenH() * 0.048,
              //     // Adapt HH 0.048
            ),
            Container(
              padding: EdgeInsets.only(left: medQryWidth * 0.03
                  //  Adapt.px(22)
                  ),
              width: medQryWidth,
              height: medQryHeight * 0.2,
              //  Adapt.screenH() * 0.2,
              // Adapt HH 0.189
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColor.minColor
                  : const Color(0xff22262f),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: medQryWidth * 0.02,
                    // Adapt.screenH() * 0.01,
                    // Adapt HH 0.01
                  ),
                  CircleAvatar(
                    // minRadius: 25,
                    // use the hassan way
                    maxRadius: 35.r,
                    backgroundColor: changeColor(),
                    child: Text(
                      'G',
                      style: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    // backgroundImage:
                    //     const AssetImage('asset/images/think.jpg')
                  ),
                  SizedBox(
                    height: medQryHeight * 0.015,
                    // Adapt HH 0.03
                  ),
                  SizedBox(
                    width: medQryWidth * 0.2,
                    height: medQryWidth * 0.09,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        provLang.getText('user_name') ?? '',
                        style: TextStyle(
                            color: const Color(0xffF9FFFF),
                            fontSize: medQryWidth * 0.06,
                            //  Adapt.px(40),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: medQryHeight * 0.00,
                    //  Adapt.screenH() * 0.009,
                    // Adapt HH 0.189
                  ),
                  SizedBox(
                    width: medQryWidth * 0.5,
                    height: medQryHeight * 0.03,
                    // height: medQryHeight * 0.1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        'guest@gmail.com',
                        style: TextStyle(
                            fontSize: medQryWidth * 0.042,
                            // Adapt.px(32),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xffF9FFFF)
                                    : Colors.grey.shade500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: medQryHeight * 0.01,
                    //  Adapt.screenH() * 0.009,
                    // Adapt HH 0.189
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0xffF9FFFF)
                  : Colors.black45,
              height: medQryHeight * 0.9,
              child: Column(
                children: [
                  buildRowCuperSwitch(
                      context: context,
                      valueCuperSwitch:
                          context.watch<HomeProvider>().isTodayBreakProv,
                      isTodayBreak: true,
                      iconData: Icons.insert_page_break_outlined,
                      textSwitchCuper: provLang.getText('take_break') ?? ''),
                  buildRowCuperSwitch(
                      context: context,
                      valueCuperSwitch:
                          context.watch<ProvLanguge>().isEn == false,
                      isTodayBreak: false,
                      isEnglish: false,
                      iconData: Icons.language_outlined,
                      textSwitchCuper: provLang.getText('lan_arab') ?? ''),
                  buildRowCuperSwitch(
                      context: context,
                      valueCuperSwitch: context.watch<ProvLanguge>().isEn,
                      isTodayBreak: false,
                      isEnglish: true,
                      iconData: Icons.language_outlined,
                      textSwitchCuper: provLang.getText('lan_eng') ?? ''),
                  headofDrawer(provLang.getText('achievement_report') ?? '',
                      Icons.work_outline_rounded, context),
                  SizedBox(
                    height: medQryHeight * 0.01,
                    //  Adapt.screenH() * 0.01,
                    // Adapt HH 0.02
                  ),
                  textbuttonAchivepercnt(
                      provLang.getText('half_month_report') ?? '',
                      Icons.percent_rounded,
                      context,
                      const AchivementScreen()),
                  textbuttonAchivepercnt(
                      provLang.getText('month_report') ?? '',
                      Icons.percent_rounded,
                      context,
                      const AchivementMonthlyScreen()),
                  textbuttonAchivepercnt(
                      provLang.getText('yearly_report') ?? '',
                      Icons.percent_rounded,
                      context,
                      const AchivementYearScreen()),
                  SizedBox(
                    height: medQryHeight * 0.02,
                    // Adapt.screenH() * 0.01,
                    // Adapt HH 0.02
                  ),
                  headofDrawer(provLang.getText('all_task') ?? '',
                      Icons.view_week, context),
                  SizedBox(
                    height: medQryHeight * 0.02,
                    //  Adapt.screenH() * 0.01,
                    // Adapt HH 0.02
                  ),
                  textbuttonTasks(
                      textForButton: provLang.getText('completed_task') ?? '',
                      context: context,
                      screen: const Completedtasks(),
                      iconData: Icons.done_all),
                  textbuttonTasks(
                    textForButton: provLang.getText('task_unfifnshed') ?? '',
                    context: context,
                    screen: const UnCompletedTask(),
                    iconData: Icons.remove_done,
                  ),
                  textbuttonTasks(
                      textForButton: provLang.getText('daily_achivement') ?? '',
                      context: context,
                      screen: const AllAchievment(),
                      iconData: Icons.grading_sharp),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  textbuttonAchivepercnt(String textForButton, IconData iconData,
      BuildContext context, Widget screen) {
    double medQryHeight = MyMediaQuery.getScreenHieght(context);
    double medQryWidth = MyMediaQuery.getScreenWidth(context);
    return InkWell(
      onTap: () {
        try {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return screen;
          }));
        } catch (e) {
          showToastMessageAbimation(context: context, textToast: 'Error is $e');
        }
      },
      child: SizedBox(
        height: medQryHeight * 0.06,
        width: medQryWidth,
        child: Padding(
          padding: EdgeInsets.only(
            left: medQryWidth * 0.03,
            // Adapt.px(22),
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.grey.shade500,
              ),
              SizedBox(
                width: medQryWidth * 0.04,
                //  Adapt.screenW() * 0.05,
                // Adapt WW 0.01
              ),
              // FittedBox(
              //   child:
              SizedBox(
                width: medQryWidth * 0.6,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(textForButton,
                      style: TextStyle(
                          fontSize: medQryWidth * 0.05,
                          //  Adapt.px(33),
                          fontWeight: FontWeight.w400)),
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  textbuttonTasks(
      {required String textForButton,
      required IconData iconData,
      required Widget screen,
      required BuildContext context}) {
    // Size medQry = MediaQuery.of(context).size;
    double medQryHeight = MyMediaQuery.getScreenHieght(context);
    double medQryWidth = MyMediaQuery.getScreenWidth(context);
    return InkWell(
        onTap: () {
          try {
            if (iconData == Icons.grading_sharp) {
              context.read<HomeProvider>().getProgress();
            }
            // context.read<HomeProvider>().getTask();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return screen;
            }));
          } catch (e) {
            showToastMessageAbimation(
                context: context, textToast: 'Error is $e');
          }
        },
        child: SizedBox(
            // color: Colors.red,
            height: medQryHeight * 0.06,
            width: medQryWidth,
            child: Padding(
              padding: EdgeInsets.only(left: medQryWidth * 0.03
                  // Adapt.px(22),
                  ),
              child: Row(
                children: [
                  Icon(
                    iconData,
                    color: Colors.grey.shade500,
                  ),
                  SizedBox(
                    width: medQryWidth * 0.04,
                  ),
                  // FittedBox(
                  //   child:
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Text(textForButton,
                        style: TextStyle(
                            fontSize: medQryWidth * 0.045,
                            // Adapt.px(33),
                            fontWeight: FontWeight.w400)),
                  ),
                  // ),
                ],
              ),
            )));
  }

  headofDrawer(String textHead, IconData iconData, BuildContext context) {
    double medQryHeight = MyMediaQuery.getScreenHieght(context);
    double medQryWidth = MyMediaQuery.getScreenWidth(context);
    return Container(
      width: medQryWidth,
      height: medQryHeight * 0.06,
      color: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.only(
          left: medQryWidth * 0.03,
          //  Adapt.px(22),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.grey.shade500,
            ),
            SizedBox(
              width: medQryWidth * 0.02,
              // Adapt.screenW() * 0.05,
              // Adapt WW 0.01
            ),
            // FittedBox(
            //   child:
            SizedBox(
              width: medQryWidth * 0.63,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Text(
                  textHead,
                  style: TextStyle(
                      fontSize: medQryWidth * 0.048,
                      // Adapt.px(40),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  void makeTodayBreak(BuildContext context, bool isbreakActive) {
    try {
      // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
      // print('inside makeTodayBreak');
      // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
      var readHomeProv = context.read<HomeProvider>();
      DateTime dateTimeFormatNow = DateTime.now();
      int i = 0;
      if (readHomeProv.progressList.isNotEmpty) {
        // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
        // print('inside makeTodayBreak IS NOT EMPTY');
        // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
        while (i < readHomeProv.progressList.length) {
          // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
          // print('inside makeTodayBreak IN WHILE');
          // print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII');
          if (isbreakActive) {
            if (dateTimeFormatNow.year.toString() ==
                    readHomeProv.progressList[i].dateProgressYear &&
                dateTimeFormatNow.month.toString() ==
                    readHomeProv.progressList[i].dateProgressmonth &&
                dateTimeFormatNow.day.toString() ==
                    readHomeProv.progressList[i].dateProgressToday) {
              // print('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ');
              // print('TODAY BECOME BREAK');
              // print(
              //     'QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ');
              readHomeProv.updateisTodayBreakProgress(
                  readHomeProv.progressList[i].dateProgress!,
                  'gh^%vb42TAKESBROKRESTBAFAMAMO,.><');
              readHomeProv.updateProgress(
                  readHomeProv.progressList[i].dateProgress!, 0);
            }
          }
          if (!isbreakActive) {
            if (dateTimeFormatNow.year.toString() ==
                    readHomeProv.progressList[i].dateProgressYear &&
                dateTimeFormatNow.month.toString() ==
                    readHomeProv.progressList[i].dateProgressmonth &&
                dateTimeFormatNow.day.toString() ==
                    readHomeProv.progressList[i].dateProgressToday) {
              // print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
              // print('TODAY NOT BECOME BREAK');
              // print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
              readHomeProv.updateisTodayBreakProgress(
                  readHomeProv.progressList[i].dateProgress!, '');
            }
          }
          i++;
        }
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  bool changeValueSwitchProg(BuildContext context) {
    try {
      var provHome = context.read<HomeProvider>();

      int i = 0;
      while (i < provHome.progressList.length) {
        if (provHome.progressList.isNotEmpty) {
          if (provHome.dateeOutFormat.year.toString() ==
                  provHome.progressList[i].dateProgressYear &&
              provHome.dateeOutFormat.month.toString() ==
                  provHome.progressList[i].dateProgressmonth &&
              provHome.dateeOutFormat.day.toString() ==
                  provHome.progressList[i].dateProgressToday) {
            if (provHome.progressList[i].isTodayBreak ==
                'gh^%vb42TAKESBROKRESTBAFAMAMO,.><') {
              // print('PPPPPPPPPPPPPDDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAA');
              // print('it is true');
              // print('PPPPPPPPPPPPPDDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAA');
              return true;
            } else {
              // print('PPPPPPPPPPPPPDDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAA');
              // print('it is false');
              // print('PPPPPPPPPPPPPDDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAA');
              return false;
            }
          }
        }
        i++;
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
    return false;
  }

  bool checkTaskExist(BuildContext context) {
    try {
      var provHome = context.read<HomeProvider>();
      var dateSelected = provHome.dateeOutFormat;
      int i = 0;
      while (i < provHome.taskList.length) {
        if (provHome.taskList[i].dateYearTask == dateSelected.year.toString() &&
            provHome.taskList[i].dateMonthTask ==
                dateSelected.month.toString() &&
            provHome.taskList[i].dateTodayTask == dateSelected.day.toString()) {
          return true;
        }
        i++;
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
      // showAlertDialog(context, );
    }
    return false;
  }

  buildRowCuperSwitch({
    required BuildContext context,
    String? textSwitchCuper,
    IconData? iconData,
    required bool isTodayBreak,
    bool? isEnglish,
    required bool valueCuperSwitch,
  }) {
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return Container(
      padding: EdgeInsets.only(
        left: medQryWidth * 0.03,
        right: medQryHeight * 0.012,
        // Adapt.px(22)
      ),
      width: medQryWidth,
      // Adapt.screenW(),
      height: medQryHeight * 0.06,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.grey.shade500,
          ),
          SizedBox(
            width: medQryWidth * 0.04,
            // Adapt.screenW() * 0.05,
            // Adapt WW 0.01
          ),
          SizedBox(
            width: medQryWidth * 0.4,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
                  //  FittedBox(
                  //   child:
                  Text(
                textSwitchCuper!,
                style: TextStyle(
                  fontSize: medQryWidth * 0.045,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // ),
            ),
          ),
          SizedBox(
            width: medQryWidth * 0.04,
            //  Adapt.screenW() * 0.1,
            // Adapt WW 0.01
          ),
          const Spacer(),
          CupertinoSwitch(
            value: valueCuperSwitch,
            onChanged: isTodayBreak
                ? (vlaue) async {
                    var provLang = context.read<ProvLanguge>();
                    var provHome = context.read<HomeProvider>();
                    var dateNow = DateTime.now();
                    if (provHome.dateeOutFormat.year == dateNow.year &&
                        provHome.dateeOutFormat.month == dateNow.month &&
                        provHome.dateeOutFormat.day == dateNow.day) {
                      if (checkTaskExist(context)) {
                        showToastMessageAbimation(
                            context: context,
                            textToast: provLang
                                .getText('should_delete_task_toTake_break'));
                        // showAlertDialog(context,
                        //     'You should delete the tasks first to take today break');
                        return;
                      }
                      if (vlaue) {
                        await insertProgressOfDayTasks(
                            context: context,
                            isTodayBreak: 'gh^%vb42TAKESBROKRESTBAFAMAMO,.><');
                      }
                      // ignore: use_build_context_synchronously
                      makeTodayBreak(context, vlaue);
                      // ignore: use_build_context_synchronously
                      changeValueSwitchProg(context);
                      // ignore: use_build_context_synchronously
                      context.read<HomeProvider>().changeIsTodayBreak(vlaue);
                    }
                  }
                : (value) {
                    if (isEnglish == true) {
                      context.read<ProvLanguge>().changeLanguage(true);
                      return;
                    }
                    if (isEnglish == false) {
                      context.read<ProvLanguge>().changeLanguage(false);
                      return;
                    }
                  },
          )
        ],
      ),
    );
  }

  Color changeColor() {
    List<Color> listColor = const [
      Color.fromARGB(255, 241, 188, 12),
      Color.fromARGB(255, 52, 240, 114),
      Color.fromARGB(255, 250, 60, 60),
      Color.fromARGB(255, 236, 123, 30),
    ];
    Random random = Random();

    return listColor[random.nextInt(4)];
  }
}
