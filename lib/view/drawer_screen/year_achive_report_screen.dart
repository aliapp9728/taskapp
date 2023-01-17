import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/drawer_prov/prov_achive_repport.dart';
import 'package:taskjob_aliapp/controller/prov_homepage.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';

import '../../core/app_color.dart';
import '../../core/method.dart';

class AchivementYearScreen extends StatelessWidget {
  const AchivementYearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    var showResult = checkReportAchive(context); //check toast

    calculateAchive(context); //check toast
    var averachive = calculateAchive(context) * 100;
    var watchHalfMonthProv = context.watch<AcheiveReportProv>();
    calculateAchivePercent(context: context, whichOne: 'less50');
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
                            '${provLang.getText('title_yearly_report')} ${watchHalfMonthProv.initYear}'),
                      ))),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  showDialogAchiveMeth(context); //check toast
                },
                child: FittedBox(
                  child: Text(
                    provLang.getText('change_date_year'),
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 44, 43, 43)
                            : AppColor.minColor),
                  ),
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
                        // backgroundColor:
                        //         ? Colors.grey
                        //         : const Color(0xff424F64),

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
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : const Color(0xff22262f),

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
                              '${provLang.getText('ahievement_year')} ${averachive.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 44, 43, 43),
                                  fontWeight: FontWeight.w600),
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
                              achivePercentAndDays(
                                  provLang.getText('month_achive_90_100'),
                                  calculateAchivePercent(
                                          whichOne: '90to100', context: context)
                                      .toString()),
                              achivePercentAndDays(
                                  provLang.getText('month_achive_70_90'),
                                  calculateAchivePercent(
                                          whichOne: '70to90', context: context)
                                      .toString()),
                              achivePercentAndDays(
                                  provLang.getText('month_achive_50_70'),
                                  calculateAchivePercent(
                                          whichOne: '50to70', context: context)
                                      .toString()),
                              achivePercentAndDays(
                                  provLang.getText('months_achive_less50'),
                                  calculateAchivePercent(
                                          whichOne: 'less50', context: context)
                                      .toString()),
                              // achivePercentAndDays('you taked rest',
                              //     knownAchivePercent('break', context).toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
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
                    provLang.getText('there_no_data_year'),
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
      double sumMonth = 0;
      double sumYear = 0;
      double avergeMonth = 0;

      var readHomeProv = context.read<HomeProvider>();
      var readHalfMonthProv = context.read<AcheiveReportProv>();
      int numbYear = 1;

      while (numbYear < 13) {
        if (readHomeProv.progressList.isNotEmpty) {
          int i = 0;
          while (i < readHomeProv.progressList.length) {
            if (readHomeProv.progressList[i].dateProgressYear ==
                    readHalfMonthProv.initYear &&
                readHomeProv.progressList[i].dateProgressmonth ==
                    (i + 1).toString()) {
              sumMonth += readHomeProv.progressList[i].progressOfDay!;
            }

            i++;
          }
        }
        int parseYear = int.parse(readHalfMonthProv.initYear);
        var lastDayOfMonth =
            double.parse(DateTime(parseYear, numbYear + 1, 0).day.toString());

        avergeMonth = sumMonth / lastDayOfMonth;

        sumYear += avergeMonth;
        numbYear++;
      }
      // print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      // print('sumYear sumYear sumYear $sumYear');
      // print('sumYear sumYear sumYear $sumYear');
      // print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      // print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      averAchive = sumYear / 12;
      return averAchive;
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

// Achiv Months MMMMMMMMMMMMMMMMMMMMMMMMMMM

  calculateAchivePercent(
      {required BuildContext context, required String whichOne}) {
    try {
      double averAchive = 0;
      double sum = 0;
      double dayOff = 0;
      int achive90to100Month = 0;
      int achive70to90Month = 0;
      int achive50to70Month = 0;
      int achivelessthan50Month = 0;
      int numberMonth = 1;
      int checkOnMonth = 0;
      List<double> monthOfYearList = [];

      var readHomeProv = context.read<HomeProvider>();
      var readHalfMonthProv = context.read<AcheiveReportProv>();

      if (readHomeProv.progressList.isNotEmpty) {
        while (numberMonth < 13) {
          int i = 0;
          while (i < readHomeProv.progressList.length) {
            if (readHomeProv.progressList[i].dateProgressYear ==
                    readHalfMonthProv.initYear &&
                readHomeProv.progressList[i].dateProgressmonth ==
                    numberMonth.toString()) {
              if (readHomeProv.progressList[i].isTodayBreak ==
                  'gh^%vb42TAKESBROKRESTBAFAMAMO,.><') {
                dayOff++;
              }
              // Sum of the first 15 days of the chosen month
              sum += readHomeProv.progressList[i].progressOfDay!;
            }

            i++;
          }
          int parseYear = int.parse(readHalfMonthProv.initYear);
          int parseMonth = int.parse(numberMonth.toString());
          var lastDayOfMonth = double.parse(
              DateTime(parseYear, parseMonth + 1, 0).day.toString());
          // print(
          //     'averAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          // print('day off is $dayOff of month ($numberMonth) \n');
          // print(
          //     'averAchiveaverAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          var restOfDays = lastDayOfMonth - dayOff;
          // print(
          //     'averAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          // print(
          //     'number sum is $sum restOfDays is $restOfDays lastDayOfMonth is $lastDayOfMonth  \n');
          // print(
          //     'averAchiveaverAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');

          averAchive = sum / restOfDays;
          // print(
          //     'averAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          // print('''number month is $numberMonth \n
          //    sum is $sum \n
          //    lastDayOfMonth is $lastDayOfMonth \n
          //    dayOff is $dayOff \n
          //    restOfDays is $restOfDays \n
          //    averAchive is $averAchive \n

          // ''');
          // print(
          //     'averAchiveaverAchiveaverAchiveaverAchive AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA \n');
          monthOfYearList.add(averAchive);
          dayOff = 0;
          sum = 0;
          numberMonth++;
        }
        while (checkOnMonth < monthOfYearList.length) {
          if (monthOfYearList[checkOnMonth] >= 0.90) {
            achive90to100Month++;
          }
          if (monthOfYearList[checkOnMonth] >= 0.70 &&
              monthOfYearList[checkOnMonth] < 0.90) {
            achive70to90Month++;
          }
          if (monthOfYearList[checkOnMonth] >= 0.50 &&
              monthOfYearList[checkOnMonth] < 0.7) {
            achive50to70Month++;
          }
          if (monthOfYearList[checkOnMonth] < 0.5) {
            achivelessthan50Month++;
          }

          checkOnMonth++;
        }
        // print('AAAAAAAAAAAAAAAAAAAAAAAAAAA');
        // print('list month is $monthOfYearList');
        // print('AAAAAAAAAAAAAAAAAAAAAAAAAAA');
        switch (whichOne) {
          case '90to100':
            {
              return achive90to100Month;
            }

          case '70to90':
            {
              return achive70to90Month;
            }
          case '50to70':
            {
              return achive50to70Month;
            }
          case 'less50':
            {
              return achivelessthan50Month;
            }
        }
      }
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }

  achivePercentAndDays(String percentFromTo, String numberDays) {
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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.red,
                      child: dropdow(
                          readAchiveprov.yearListHalfAchive, context, true),
                    ),
                    SizedBox(
                      height: 30.h,
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
                readhomeProv.progressList[i].dateProgressYear
            //     &&
            // readHalfMonthProv.initMonth ==
            //     readhomeProv.progressList[i].dateProgressmonth
            ) {
          // int parseYear =
          //     int.parse(readhomeProv.progressList[i].dateProgressYear!);
          // int parseMonth =
          //     int.parse(readhomeProv.progressList[i].dateProgressmonth!);
          // var date = DateTime(parseYear, parseMonth + 1, 0);
          report++;
          if (report == 365) {
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
        itemCount: 12,
        itemBuilder: (_, index) {
          var readHomeProv = context.read<HomeProvider>();
          var readHalfMonthProv = context.read<AcheiveReportProv>();
          var progressList = readHomeProv.progressList[index];
          // will just put a condition if they were the same date will show it
          if (readHomeProv.progressList[index].dateProgressYear ==
              readHalfMonthProv.initYear) {
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
                      LinearPercentIndicator(
                        isRTL: provLang.isEn ? false : true,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey
                                : const Color(0xff424F64),
                        restartAnimation: false,
                        animateFromLastPercent: true,
                        animation: true,
                        animationDuration: 3000,
                        progressColor: (calculateAchiveOfMonths(
                                        context, (index + 1).toString()) ??
                                    0) >
                                0.70
                            ? ((calculateAchiveOfMonths(
                                            context, (index + 1).toString()) ??
                                        0) >
                                    0.80
                                ? Colors.greenAccent.shade400
                                : const Color.fromARGB(255, 245, 229, 13))
                            : ((calculateAchiveOfMonths(
                                            context, (index + 1).toString()) ??
                                        0) >=
                                    0.50
                                ? Colors.orange
                                : Colors.red),
                        percent: calculateAchiveOfMonths(
                                context, (index + 1).toString()) ??
                            0,
                        // JUST COPY
                        lineHeight: 30.h,
                        barRadius: Radius.circular(30.r),
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        center: FittedBox(
                          child: Text(
                              '${(calculateAchiveOfMonths(context, (index + 1).toString()) * 100).toStringAsFixed(1)} %'),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      FittedBox(
                        child: Text(
                          provLang.isEn
                              ? '${provLang.getText('lis_prog_date_year')} ${index + 1} - ${progressList.dateProgressYear} '
                              : '${provLang.getText('lis_prog_date_year')} ${index + 1} - ${progressList.dateProgressYear}',

                          // '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressYear} - ${index + 1} ',
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

  calculateAchiveOfMonths(BuildContext context, String monthNumber) {
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
              readHomeProv.progressList[i].dateProgressmonth == monthNumber) {
            if (readHomeProv.progressList[i].isTodayBreak != '') {
              dayOff++;
            }
            sum += readHomeProv.progressList[i].progressOfDay!;
          }

          i++;
        }
      }
      int parseYear = int.parse(readHalfMonthProv.initYear);
      int parseMonth = int.parse(monthNumber);
      var lastDayOfMonth =
          double.parse(DateTime(parseYear, parseMonth + 1, 0).day.toString());
      var restOfDays = lastDayOfMonth - dayOff;

      averAchive = sum / restOfDays;

      return averAchive;
    } catch (e) {
      showToastMessageAbimation(context: context, textToast: 'Error is $e');
    }
  }
}
