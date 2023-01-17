import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/drawer_prov/prov_achive_repport.dart';
import 'package:taskjob_aliapp/controller/prov_homepage.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';

import '../../core/app_color.dart';
import '../../core/method.dart';

class AchivementMonthlyScreen extends StatelessWidget {
  const AchivementMonthlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    var showResult = checkReportAchive(context); //check toast

    calculateAchive(context); //check toast
    var averachive = calculateAchive(context) * 100;
    var watchHalfMonthProv = context.watch<AcheiveReportProv>();

    return Directionality(
      textDirection: provLang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.minColor
              : const Color(0xff22262f),
          title: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FittedBox(
                        child: Text(
                            '${provLang.getText('title_Month_report')} ${watchHalfMonthProv.initMonth}'),
                      ))),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  //check toast
                  showDialogAchiveMeth(context);
                },
                child: FittedBox(
                  child: Text(provLang.getText('change_date'),
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(255, 44, 43, 43)
                                  : AppColor.minColor)),
                ))
          ],
        ),
        body: showResult
            ? SafeArea(
                child: Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 197, 233, 233)
                    : const Color(0xff424F64),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25.h,
                        // HH 8
                      ),
                      CircularPercentIndicator(
                        lineWidth: 20.w,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : const Color(0xff22262f),

                        restartAnimation: false,
                        animateFromLastPercent: true,
                        animation: true,
                        animationDuration: 3000,
                        //check toast all
                        progressColor: (calculateAchive(context) ?? 0) > 0.70
                            ? ((calculateAchive(context) ?? 0) > 0.80
                                ? Colors.greenAccent.shade400
                                : const Color.fromARGB(255, 245, 229, 13))
                            : ((calculateAchive(context) ?? 0) >= 0.50
                                ? Colors.orange
                                : Colors.red),
                        percent: calculateAchive(context) ?? 0,

                        // COPY ABOVE
                        radius: 75.r,
                        // HH 12
                        backgroundWidth: 20.w,
                        center: FittedBox(
                          child: Text(
                            '${averachive.toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: 25.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        // HH 10
                      ),
                      Container(
                          width: 250.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[200]
                                  : const Color(0xff99c8cd),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                              child: FittedBox(
                            child: Text(
                              '${provLang.getText('ahievement_month')} ${averachive.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 44, 43, 43),
                                  fontWeight: FontWeight.w500),
                            ),
                          ))),
                      SizedBox(
                        height: 20.h,
                        // HH 10
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          height: 150.h,
                          // HH 20
                          padding: EdgeInsets.only(
                              left: 25.w, top: 10.h, bottom: 10.h),
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[200]
                                  : const Color(0xff99c8cd),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // No Need
                              achivepercentAndDays(
                                  provLang.getText('days_achive_90_100'),
                                  knownAchivePercent('90to100', context)
                                      .toString()),
                              achivepercentAndDays(
                                  provLang.getText('days_achive_70_90'),
                                  knownAchivePercent('70to90', context)
                                      .toString()),
                              achivepercentAndDays(
                                  provLang.getText('days_achive_50_70'),
                                  knownAchivePercent('50to70', context)
                                      .toString()),
                              achivepercentAndDays(
                                  provLang.getText('days_achive_less50'),
                                  knownAchivePercent('less50', context)
                                      .toString()),
                              achivepercentAndDays(
                                  provLang.getText('days_take_rest'),
                                  knownAchivePercent('break', context)
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // No Need
                      methodListViewBuilder(context),
                    ],
                  ),
                ),
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 197, 233, 233)
                    : const Color(0xff424F64),
                child: Center(
                    child: FittedBox(
                  child: Text(
                    provLang.getText('there_no_data_halfMonth'),
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                )),
              ),
      ),
    );
  }

  calculateAchive(BuildContext context) {
    try {
      double averAchive = 0;
      double sum = 0;
      double dayOff = 0;

      var readHomeProv = context.read<HomeProvider>();
      var readHalfMonthProv = context.read<AcheiveReportProv>();

      if (readHomeProv.progressList.isNotEmpty) {
        int i = 0;
        while (i < readHomeProv.progressList.length) {
          if (readHomeProv.progressList[i].dateProgressYear ==
                  readHalfMonthProv.initYear &&
              readHomeProv.progressList[i].dateProgressmonth ==
                  readHalfMonthProv.initMonth) {
            if (readHomeProv.progressList[i].isTodayBreak != '') {
              dayOff++;
            }
            // Sum of the first 15 days of the chosen month
            sum += readHomeProv.progressList[i].progressOfDay!;
          }

          i++;
        }
      }
      int parseYear = int.parse(readHalfMonthProv.initYear);
      int parseMonth = int.parse(readHalfMonthProv.initMonth);
      var lastDayOfMonth =
          double.parse(DateTime(parseYear, parseMonth + 1, 0).day.toString());
      var restOfDays = lastDayOfMonth - dayOff;
      // print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      // print('dayOff $dayOff');
      // print('restOfDays $restOfDays');
      // print('Summm $sum');
      // print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      averAchive = sum / restOfDays;
      // print('SUM   SSSSSSSSSSSSSSSSSSSSSSSSSSS  $lastDayOfMonth');
      // print('SUM   SSSSSSSSSSSSSSSSSSSSSSSSSSS  $sum');
      // print('averAchive   AAAAAAAAAAAAAAAAAAAAAAAAAAAAA  $averAchive');
      return averAchive;
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  knownAchivePercent(String whichOne, BuildContext context) {
    try {
      var readHomeProv = context.read<HomeProvider>();
      var readHalfMonthProv = context.read<AcheiveReportProv>();
      int achive90to100 = 0;
      int achive70to90 = 0;
      int achive50to70 = 0;
      int achivelessthan50 = 0;
      int dayBreak = 0;
      int parseYear = int.parse(readHalfMonthProv.initYear);
      int parseMonth = int.parse(readHalfMonthProv.initMonth);
      var lastDayOfMonth =
          double.parse(DateTime(parseYear, parseMonth + 1, 0).day.toString());
      if (readHomeProv.progressList.isNotEmpty) {
        int i = 0;
        while (i < readHomeProv.progressList.length) {
          if (readHomeProv.progressList[i].dateProgressYear ==
                  readHalfMonthProv.initYear &&
              readHomeProv.progressList[i].dateProgressmonth ==
                  readHalfMonthProv.initMonth &&
              int.parse(readHomeProv.progressList[i].dateProgressToday!) <
                  lastDayOfMonth) {
            if (readHomeProv.progressList[i].progressOfDay! >= 0.90 &&
                readHomeProv.progressList[i].isTodayBreak == '') {
              achive90to100++;
            }
            if (readHomeProv.progressList[i].progressOfDay! >= 0.70 &&
                readHomeProv.progressList[i].progressOfDay! < 0.90 &&
                readHomeProv.progressList[i].isTodayBreak == '') {
              achive70to90++;
            }
            if (readHomeProv.progressList[i].progressOfDay! >= 0.50 &&
                readHomeProv.progressList[i].progressOfDay! < 0.7 &&
                readHomeProv.progressList[i].isTodayBreak == '') {
              achive50to70++;
            }
            if (readHomeProv.progressList[i].progressOfDay! < 0.5 &&
                readHomeProv.progressList[i].isTodayBreak == '') {
              achivelessthan50++;
            }
            if (readHomeProv.progressList[i].isTodayBreak ==
                'gh^%vb42TAKESBROKRESTBAFAMAMO,.><') {
              dayBreak++;
            }
          }

          i++;
        }
      }
      switch (whichOne) {
        case '90to100':
          {
            return achive90to100;
          }

        case '70to90':
          {
            return achive70to90;
          }
        case '50to70':
          {
            return achive50to70;
          }
        case 'less50':
          {
            return achivelessthan50;
          }
        case 'break':
          {
            return dayBreak;
          }
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  achivepercentAndDays(String percentFromTo, String numberDays) {
    // No Need
    var textStyle = const TextStyle(
        color: Color.fromARGB(255, 44, 43, 43), fontWeight: FontWeight.w600);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            percentFromTo,
            style: textStyle,
          ),
        ),
        FittedBox(
          child: Text(
            numberDays,
            style: textStyle,
          ),
        )
      ],
    );
  }

  dropdow(List<String> listofCheck, BuildContext context, bool isYear) {
    // No Need
    var provLang = context.watch<ProvLanguge>();
    var watchAchiveprov = context.watch<AcheiveReportProv>();
    var textValue =
        isYear ? watchAchiveprov.initYear : watchAchiveprov.initMonth;
    // ? 'Year is${watchAchiveprov.initYear}'
    // : 'Month is${watchAchiveprov.initMonth}';
    return DropdownButton(
      borderRadius: BorderRadius.circular(10.r),
      items: listofCheck
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem(
              value: value.toString(),
              child: FittedBox(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: Text(isYear
                ? '${provLang.getText('year_drop_halfMonth')} $textValue'
                : '${provLang.getText('month_drop_halfMonth')} $textValue'),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ],
      ),

      iconSize: 32,
      elevation: 4,
      underline: Container(height: 1.h),
      // style: subTitleStyle,
      dropdownColor: Colors.blueGrey,
      onChanged: (String? newValue) {
        isYear
            ? context.read<AcheiveReportProv>().changeInitYear(newValue!)
            : context.read<AcheiveReportProv>().changeInitMonth(newValue!);
      },
    );
  }

  showDialogAchiveMeth(BuildContext context) {
    try {
      var readAchiveprov = context.read<AcheiveReportProv>();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xff22262f),
              content: SizedBox(
                height: 130.h,
                child: Column(
                  children: [
                    Container(
                      color: Colors.red,
                      child: dropdow(
                          readAchiveprov.yearListHalfAchive, context, true),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      color: Colors.red,
                      child: dropdow(
                          readAchiveprov.monthListHalfAchive, context, false),
                    ),
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  checkReportAchive(BuildContext context) {
    try {
      // To check if the chosen month had ended
      var readhomeProv = context.read<HomeProvider>();
      var readHalfMonthProv = context.read<AcheiveReportProv>();
      int i = 0;
      int report = 0;
      while (i < readhomeProv.progressList.length) {
        if (readHalfMonthProv.initYear ==
                readhomeProv.progressList[i].dateProgressYear &&
            readHalfMonthProv.initMonth ==
                readhomeProv.progressList[i].dateProgressmonth) {
          int parseYear =
              int.parse(readhomeProv.progressList[i].dateProgressYear!);
          int parseMonth =
              int.parse(readhomeProv.progressList[i].dateProgressmonth!);
          var date = DateTime(parseYear, parseMonth + 1, 0);
          report++;
          if (report == date.day) {
            return true;
          }
        }
        i++;
      }
      return false;
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  methodListViewBuilder(BuildContext context) {
    // No Need
    var provLang = context.watch<ProvLanguge>();
    var textStyle = TextStyle(
      color: Colors.grey[200],
    );
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.read<HomeProvider>().progressList.length,
        itemBuilder: (_, index) {
          var readHomeProv = context.read<HomeProvider>();
          var readHalfMonthProv = context.read<AcheiveReportProv>();
          var progressList = readHomeProv.progressList[index];
          // will just put a condition if they were the same date will show it
          if (readHomeProv.progressList[index].dateProgressYear ==
                  readHalfMonthProv.initYear &&
              readHomeProv.progressList[index].dateProgressmonth ==
                  readHalfMonthProv.initMonth) {
            return Column(
              children: [
                Container(
                  width: 350.w,
                  height: 80.h,
                  padding: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColor.minColor
                          : const Color(0xff22262f),
                      borderRadius: BorderRadius.circular(90.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      progressList.isTodayBreak == ''
                          ? LinearPercentIndicator(
                              isRTL: provLang.isEn ? false : true,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey
                                  : const Color(0xff424F64),
                              restartAnimation: false,
                              animateFromLastPercent: true,
                              animation: true,
                              animationDuration: 3000,
                              progressColor: (progressList.progressOfDay ?? 0) >
                                      0.70
                                  ? ((progressList.progressOfDay ?? 0) > 0.80
                                      ? Colors.greenAccent.shade400
                                      : const Color.fromARGB(255, 245, 229, 13))
                                  : ((progressList.progressOfDay ?? 0) >= 0.50
                                      ? Colors.orange
                                      : Colors.red),
                              percent: progressList.progressOfDay ?? 0,
                              // JUST COPY
                              // backgroundColor: const Color(0xff424F64),
                              lineHeight: 30.h,
                              barRadius: Radius.circular(30.r),
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              center: FittedBox(
                                child: FittedBox(
                                  child: Text(
                                      '${(progressList.progressOfDay! * 100).toStringAsFixed(1)} %'),
                                ),
                              ),
                            )
                          : Container(
                              width: 150.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    provLang.getText('lis_prog_take_rest'),
                                    style: textStyle.copyWith(
                                        color: const Color.fromARGB(
                                            255, 44, 43, 43),
                                        fontWeight: FontWeight.w500),
                                    // textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 6.h,
                      ),
                      FittedBox(
                        child: Text(
                          provLang.isEn
                              ? '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressmonth} - ${progressList.dateProgressToday} - ${progressList.dateProgressYear}'
                              : '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressToday} - ${progressList.dateProgressmonth} - ${progressList.dateProgressYear}',

                          // '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressYear} - ${progressList.dateProgressmonth} - ${progressList.dateProgressToday}',
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
              ],
            );
          } else {
            return Container();
          }
        }
        // ),
        );
  }
}

// Deprecated
class DropDownDate extends StatefulWidget {
  const DropDownDate({Key? key}) : super(key: key);

  @override
  State<DropDownDate> createState() => _DropDownDateState();
}

class _DropDownDateState extends State<DropDownDate> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // showAlertDia(context);
      },
      child: const FittedBox(child: Text('button')),
    );
  }

  showAlertDia(BuildContext context) {
    try {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0.r)),
              content: SizedBox(
                width: 90.w,
                child: Row(
                  children: [Expanded(child: TextFormField())],
                ),
              ),
            );
          });
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }
}
