import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../controller/prov_homepage.dart';
import '../model/progress_model.dart';

// INSERT PROGRESS

Future<void> insertProgressOfDayTasks(
    {required BuildContext context, String? isTodayBreak}) async {
  try {
    // try {
    checkDateProgress(context);
    // ignore: unused_local_variable
    bool checkDateProg = checkDateProgress(context);
    var prov = context.read<HomeProvider>();
    DateTime dateNow = DateTime.now();
    final dateNowUtc = DateTime.utc(dateNow.year, dateNow.month, dateNow.day);
    final dateSelectedUtcWithoutFormat = DateTime.utc(prov.dateeOutFormat.year,
        prov.dateeOutFormat.month, prov.dateeOutFormat.day - 1);
    int i = 0;
    if (prov.progressList.isEmpty) {
      print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      print('progress is empty');
      print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      await insertProgressHome(context: context, isTodayBreak: isTodayBreak);
    }
    /* when the button get  pressed to  report`s show such half-month  and the user skipped somedays without doing any jobs
  in that case we will 
  */
    if (prov.progressList.isNotEmpty) {
      prov.progressList.last;
      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      print('prov.progressList.last ${prov.progressList.last.dateProgress}');
      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      var parseFirstProgYear =
          int.parse(prov.progressList.last.dateProgressYear!);
      var parseFirstProgMonth =
          int.parse(prov.progressList.last.dateProgressmonth!);
      var parseFirstProgDay =
          int.parse(prov.progressList.last.dateProgressToday!);

      var firstProgress = DateTime.utc(
          parseFirstProgYear, parseFirstProgMonth, parseFirstProgDay);

      while (i < dateNowUtc.difference(firstProgress).inDays) {
        // var newDateOut = firstProgress.toUtc().add(Duration(days: i + 1));
        // var dateFormatUtc = DateFormat.yMEd().format(newDateOut);
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print(' dateNowUtc $dateNowUtc');
        // print('dateSelectedUtcWithoutFormat $dateSelectedUtcWithoutFormat');
        // print('firstProgress $firstProgress');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // prov.progressList[i].id       1
        // prov.progressList[i].dateProgress     2
        // prov.progressList[i].dateProgressToday     3
        // prov.progressList[i].dateProgressYear     4
        // prov.progressList[i].dateProgressmonth     5
        // prov.progressList[i].isTodayBreak     6
        // prov.progressList[i].progressOfDay     7
        // print('dateFormatUtc $dateFormatUtc');
        // print('new Date GGGG $i');
        // print('lenght ${prov.progressList}');
        print('lenght ${prov.progressList.length}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print('id id id ${prov.progressList[i].id}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print('dateProgress id id ${prov.progressList[i].dateProgress}');
        // print('isTodayBreak ${prov.progressList[i].isTodayBreak}');
        // print('progressOfDay ${prov.progressList[i].progressOfDay}');
        // print('year ${prov.progressList[i].dateProgressYear}');
        // print('month ${prov.progressList[i].dateProgressmonth}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print('day day ${prov.progressList[i].dateProgressToday}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print('dateProgress day 18 ${prov.progressList[i + 1].dateProgress}');
        // print('day 18 ${prov.progressList[i + 1].dateProgressToday}');
        // print('day 18 ${prov.progressList[i + 1].dateProgressmonth}');
        // print('day 18 ${prov.progressList[i + 1].dateProgressYear}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
        // print('22222222222222222222222222222222222222222222222222222');
        // print('dateProgress day 18 ${prov.progressList[i + 1].dateProgress}');
        // print('day 18 ${prov.progressList[i + 2].dateProgressToday}');
        // print('day 18 ${prov.progressList[i + 2].dateProgressmonth}');
        // print('day 18 ${prov.progressList[i + 2].dateProgressYear}');
        // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');

        // var newDateOut = firstProgress.toUtc().add(Duration(days: i));
        // print('DDDDDDddDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
        // print('diffrences  $dateNowUtc');
        // print('diffrences  $firstProgress');
        // print('diffrences  ${dateNowUtc.difference(firstProgress).inDays}');
        // print('new date  $newDateOut');
        // print('DDDDDDddDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
        if (dateSelectedUtcWithoutFormat.isBefore(dateNowUtc) &&
                dateSelectedUtcWithoutFormat.isAfter(firstProgress) ||
            (dateSelectedUtcWithoutFormat == firstProgress)) {
          print('هس لاثبخقث');
          var newDate = firstProgress.toUtc().add(Duration(days: i + 1));
          // print('DDDDDDddDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
          // print(
          //     'diffrences  ${dateNowUtc.difference(dateSelectedUtcWithoutFormat).inDays}');
          // print('new date  $newDate');
          // print('DDDDDDddDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
          var loopProgList = 0;
          var progNotExist = 0;

          while (loopProgList < prov.progressList.length) {
            // print('هس INSIDE WHILE  LOOP PREGRESS');
            if (
                // day
                // in case years and months are equel but days difference
                (prov.progressList[loopProgList].dateProgressYear ==
                            newDate.year.toString() &&
                        prov.progressList[loopProgList].dateProgressmonth ==
                            newDate.month.toString() &&
                        prov.progressList[loopProgList].dateProgressToday !=
                            newDate.day.toString()) ||
                    // Month
                    // in case years  are equel but months difference
                    (prov.progressList[loopProgList].dateProgressYear ==
                            newDate.year.toString() &&
                        prov.progressList[loopProgList].dateProgressmonth !=
                            newDate.month.toString()
                    // &&
                    // prov.progressList[i].dateProgressToday !=
                    //    newDate.day.toString()

                    ) ||
                    //  Year
                    (prov.progressList[loopProgList].dateProgressYear !=
                        newDate.year.toString()
                    // &&
                    // prov.progressList[i].dateProgressmonth !=
                    //     newDate.month.toString()
                    // &&
                    // prov.progressList[i].dateProgressToday !=
                    //    newDate.day.toString()

                    )) {
              // print('هس INSIDE THE INSERT');

              progNotExist++;

              if (progNotExist == prov.progressList.length) {
                if ((newDate.year == prov.dateeOutFormat.year &&
                        newDate.month == prov.dateeOutFormat.month &&
                        newDate.day != prov.dateeOutFormat.day) ||
                    (newDate.year == prov.dateeOutFormat.year &&
                        newDate.month != prov.dateeOutFormat.month) ||
                    (newDate.year != prov.dateeOutFormat.year)) {
                  isTodayBreak = '';
                }
                var dateFormatUtc = DateFormat.yMEd().format(newDate);
                await insertProgressHome(
                    context: context,
                    isTodayBreak: isTodayBreak,
                    dateProgress: dateFormatUtc,
                    year: newDate.year.toString(),
                    month: newDate.month.toString(),
                    day: newDate.day.toString());
                await prov.getProgress();
              }
            }
            loopProgList++;
          }
        }
        ++i;
      }
    }
    // } catch (e) {
    //   showAlertDialog(context, 'The Error is $e');
    // }

  } catch (e) {
    showToastMessageAbimation(context: context, textToast: 'Error is $e');
  }
}

// to check if Progresslist has dateTime of now or not
bool checkDateProgress(BuildContext context) {
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
        // prov.progres = value * 0.01;
        return true;
      }
    }
    ++i;
  }
  return false;
}

// Method of insert progress
Future<void> insertProgressHome({
  required BuildContext context,
  String? dateProgress,
  String? year,
  String? month,
  String? day,
  String? isTodayBreak,
}) async {
  try {
    print('+++++++++++++++++++++++++++++++++++++++++++++++');
    print('Now we add new Progress');
    print('+++++++++++++++++++++++++++++++++++++++++++++++');
    try {
      print('PROGRES IIIIIIIIIIII ${context.read<HomeProvider>().progres}');
      await context.read<HomeProvider>().addProgress(
              progressTasks: ProgressTasks(
            dateProgress:
                dateProgress ?? context.read<HomeProvider>().dateeText,
            dateProgressYear: year ??
                context.read<HomeProvider>().dateeOutFormat.year.toString(),
            dateProgressmonth: month ??
                context.read<HomeProvider>().dateeOutFormat.month.toString(),
            dateProgressToday: day ??
                context.read<HomeProvider>().dateeOutFormat.day.toString(),
            progressOfDay: 0,
            //  context.read<HomeProvider>().progres,
            isTodayBreak: isTodayBreak ?? '',
          ));
      // return;
    } catch (e) {
      print('Proplem of Progress is $e');
    }
    // }
    // }
    // }

    // if (context.read<HomeProvider>().taskList.isNotEmpty &&
    //     context.read<HomeProvider>().dateeText ==
    //         DateFormat.yMEd().format(DateTime.now())) {
    //   print('+++++++++++++++++++++++++++++++++++++++++++++++');
    //   print('Now we add new Progress');
    //   try {
    //     context.read<HomeProvider>().addProgress(
    //         progressTasks: ProgressTasks(
    //             dateTask: context.read<HomeProvider>().dateeText,
    //             progressOfDay: context.read<HomeProvider>().progres));
    //   } catch (e) {
    //     print('Proplem of Progress is $e');
    //   }
    // }

  } catch (e) {
    showToastMessageAbimation(context: context, textToast: 'Error is $e');
  }
}

// INSERT PROGRESS
double isProgresMaximum({required BuildContext context, int? idTask}) {
  var readProv = context.read<HomeProvider>();
  int i = 0;
  double progTotalDay = 0;
  double achiveTask = 0;
  // what if task list was empty?
  if (readProv.taskList.isNotEmpty) {
    while (i < readProv.taskList.length) {
      // print('readProv.taskList.length is ${readProv.taskList.length}');
      // print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      if (readProv.dateeOutFormat.year.toString() ==
              readProv.taskList[i].dateYearTask &&
          readProv.dateeOutFormat.month.toString() ==
              readProv.taskList[i].dateMonthTask &&
          readProv.dateeOutFormat.day.toString() ==
              readProv.taskList[i].dateTodayTask) {
        // if (progTotalDay >= 100) {
        //   return true;
        // }
        if (readProv.taskList[i].id == idTask) {
          achiveTask +=
              double.parse(readProv.taskList[i].achivement.toString());
        }
        progTotalDay += double.parse(readProv.taskList[i].achivement!);
        // print('Total is $progTotalDay');
        // print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
      }
      i++;
    }
    progTotalDay -= achiveTask;
    return progTotalDay;
  }
  return 0;
}

// Toast Message animation

void showToastMessageAbimation(
    {required BuildContext context, required String textToast}) {
  print('TOASTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
  print('Show Toast Message $textToast');
  print('Show Toast Length ${textToast.length}');
  print('TOASTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
  showToastWidget(
    Center(
        child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(255, 58, 57, 57)
                : Colors.red,
            child: Text(
              textToast,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ))),

    position: StyledToastPosition.center,

    // "hello styled toast",
    // alignment: Alignment.topCenter,
    duration: Duration(milliseconds: textToast.length < 54 ? 6000 : 8000),
    axis: Axis.horizontal,
    context: context,
    animation: StyledToastAnimation.size,
    animDuration: const Duration(milliseconds: 900),
  );
}
// void showAlertDialog(BuildContext context, String textAlert)
//  {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           // actions: [
//           //   Center(
//           //       child: MaterialButton(
//           //           child: const Text('Button'), onPressed: () {}))
//           // ],
//           shape: RoundedRectangleBorder(
//               side: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
//           content: Text(
//             textAlert,
//             style: GoogleFonts.lato(
//                 textStyle: const TextStyle(
//               wordSpacing: 1,
//               letterSpacing: 0.2,
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//               color: Colors.grey,
//             )),
//           ),
//         );
//       });
// }

void sumAndMinusProgress(BuildContext context, bool isSum, taskAchivement) {
  try {
    print('HERE THE SUM METHOD');
    print('HHHHHHHHHHHHHHHHHHHHHHHHHHHH');
    var readProv = context.read<HomeProvider>();
    var dateFormatNowSumMin = DateFormat.yMEd().format(DateTime.now());
    int i = 0;
    if (readProv.progressList.isEmpty) {
      print('Sum METHOD NOW IS EMPTY');
      print('EMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTYEMPTY');
      if (isSum &&
          readProv.progres + double.parse(taskAchivement.toString()) * 0.01 <=
              1.0) {
        readProv.progres += double.parse(taskAchivement.toString()) * 0.01;
        readProv.updateProgress(dateFormatNowSumMin,
            double.parse(readProv.progres.toStringAsFixed(3)));
      }
    }
    if (readProv.progressList.isNotEmpty) {
      while (i < readProv.progressList.length) {
        // print('SUM METHOD  IS NOT EMPTY');
        // print('NOT EMPTYNOT EMPTYNOT EMPTYNOT EMPTYNOT EMPTYNOT EMPTYNOT EMPTY');
        // print('HERE THE LOOOP METHOD');
        // print('LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL');

        // it was active at 10/14/2022
        // readProv.getProgress();
        if (readProv.progressList[i].dateProgressYear ==
                readProv.dateeOutFormat.year.toString() &&
            readProv.progressList[i].dateProgressmonth ==
                readProv.dateeOutFormat.month.toString() &&
            readProv.progressList[i].dateProgressToday ==
                readProv.dateeOutFormat.day.toString()) {
          // print('HERE THE PROGRES METHOD');
          // print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');
          // HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
          if (isSum &&
              readProv.progressList[i].progressOfDay! +
                      double.parse(taskAchivement.toString()) * 0.01 <=
                  1.0) {
            // print('HERE THE SUM CALCUCALTE');
            // print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
            readProv.getProgress();
            if (readProv.progressList[i].progressOfDay! +
                    double.parse(taskAchivement.toString()) * 0.01 >
                1) {
              readProv.progressList[i].progressOfDay = 1;
              readProv.updateProgress(dateFormatNowSumMin,
                  double.parse(readProv.progres.toStringAsFixed(3)));
              print('#######################################');
              print('Progres is 1');
            }
            print(
                'Sum Progres is ${(readProv.progressList[i].progressOfDay!).toStringAsFixed(1)}');

            readProv.progressList[i].progressOfDay =
                (readProv.progressList[i].progressOfDay! +
                    double.parse(taskAchivement.toString()) * 0.01);
            readProv.updateProgress(
                dateFormatNowSumMin,
                double.parse(readProv.progressList[i].progressOfDay!
                    .toStringAsFixed(3)));

            print(
                'After Sum Progres is ${(readProv.progressList[i].progressOfDay! * 100).toStringAsFixed(2)}');
          }

          // MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
          // Minus operation
          if (!isSum &&
              readProv.progressList[i].progressOfDay! -
                      double.parse(taskAchivement.toString()) * 0.01 >=
                  0) {
            print(
                'Minus Progres is ${readProv.progressList[i].progressOfDay!}');
            readProv.progressList[i].progressOfDay =
                readProv.progressList[i].progressOfDay! -
                    double.parse(taskAchivement.toString()) * 0.01;
            // print(
            //     '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
            // print(
            //     'Minus Progres after is ${readProv.progres}');
            readProv.updateProgress(
                dateFormatNowSumMin,
                double.parse(readProv.progressList[i].progressOfDay!
                    .toStringAsFixed(3)));
            // print(
            //     'After Minus Progres is ${context.read<HomeProvider>().progres}');
          }

          // HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
        } else {
          // print('Progress of the day don`t exciste yes ');
          // print('excisteexcisteexcisteexcisteexcisteexcisteexcisteexciste');
        }
        i++;
      }
    }
  } catch (e) {
    showToastMessageAbimation(context: context, textToast: 'Error is $e');
  }
}
