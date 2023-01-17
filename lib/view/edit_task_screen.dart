import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/prov_edit_task.dart';
import 'package:taskjob_aliapp/controller/prov_homepage.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';
import 'package:taskjob_aliapp/model/task_uncomp.dart';

import '../core/app_color.dart';
import '../core/method.dart';

class EditTask extends StatelessWidget {
  const EditTask({
    Key? key,
    required this.dateTaskYear,
    required this.dateTaskMonth,
    required this.dateTaskToday,
    required this.taskText,
    required this.taskAchive,
    required this.id,
    required this.deleteTask,
    required this.isComplated,
  }) : super(key: key);
  final String dateTaskYear;
  final String dateTaskMonth;
  final String dateTaskToday;
  final String taskText;
  final String taskAchive;
  final int id;
  final DoTask deleteTask;
  final int isComplated;

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return Directionality(
      textDirection: provLang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? const Color.fromARGB(255, 222, 235, 235)
            : const Color(0xff424F64),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  try {
                    var readprovEdit = context.read<EditTaskProvider>();
                    var readprovHome = context.read<HomeProvider>();
                    var totalPercent =
                        isProgresMaximum(context: context, idTask: id);
                    totalPercent += double.parse(
                        readprovEdit.controllerAchivement.text.toString());
                    if (totalPercent > 100) {
                      showToastMessageAbimation(
                          context: context,
                          textToast:
                              '${provLang.getText('total_percent_part_one')} $totalPercent ${provLang.getText('total_percent_part_two')}');
                      // showAlertDialog(context,
                      //     'Total of percentage is $totalPercent more than 100  Decrease the percentage of other tasks  Or delete unNecessary tasks');
                      return;
                    } else {
                      final dateprovEditOutFormat =
                          context.read<EditTaskProvider>().dateeOutFormatEdit;
                      final datenow = DateTime.now();
                      if (dateprovEditOutFormat.year == datenow.year &&
                          dateprovEditOutFormat.month == datenow.month &&
                          (dateprovEditOutFormat.day < datenow.day)) {
                        showToastMessageAbimation(
                            context: context,
                            textToast:
                                provLang.getText('cant_add_task_toPast'));
                        // showAlertDialog(context, 'You can`t add Task to past');
                        context
                            .read<EditTaskProvider>()
                            .dateOutFormatEditSet(DateTime.now());
                      } else {
                        readprovHome.updateTextTask(
                            id, readprovEdit.controllerTask.text);
                        readprovHome.markTaskAchivement(
                            id, readprovEdit.controllerAchivement.text);
                        context.read<HomeProvider>().updateDateTaskProvYear(
                            id,
                            context
                                .read<EditTaskProvider>()
                                .dateTextEditProYear);
                        context.read<HomeProvider>().updateDateTaskProvMonth(
                            id,
                            context
                                .read<EditTaskProvider>()
                                .dateTextEditProMonth);
                        context.read<HomeProvider>().updateDateTaskProvToday(
                            id,
                            context
                                .read<EditTaskProvider>()
                                .dateTextEditProToday);
                        if (isComplated == 1) {
                          var sum = double.parse(
                                  readprovEdit.controllerAchivement.text) -
                              double.parse(taskAchive);
                          sumAndMinusProgress(context, true, sum);
                          // print('Achive Controller is $sum');
                          // print(
                          //     'Achive ControllerAchive ControllerAchive ControllerAchive ControllerAchive ControllerAchive Controller');
                        }
                        Navigator.pop(context);
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => const HomeNav()));
                      }
                    }
                  } catch (e) {
                    showToastMessageAbimation(
                        context: context, textToast: 'Error is $e');
                  }
                },
                child: SizedBox(
                  width: medQryWidth * 0.08,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      provLang.getText('save_btn_edit_task'),
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: const Color(0xffF9FFFF),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
          ],
          centerTitle: true,
          title: SizedBox(
              width: medQryWidth * 0.3,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Text(provLang.getText('title_edit_task')))),
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.minColor
              : const Color(0xff22262f),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffF9FFFF),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.only(top: 15.h, bottom: 15.h, left: 15.w, right: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BuildTextFields(
                task: taskText,
                achivement: taskAchive,
              ),
              SizedBox(
                height: medQryHeight * 0.1,
              ),
              buildListTile(
                  leadIcons: Icons.calendar_month,
                  titleList: provLang.getText('due_date_edit_task'),
                  widgetList: TextButton(
                    onPressed: () {
                      try {
                        final dateprovEditOutFormat =
                            context.read<EditTaskProvider>().dateeOutFormatEdit;
                        final datenow = DateTime.now();
                        if (isComplated == 1) {
                          showToastMessageAbimation(
                              context: context,
                              textToast: provLang.getText(
                                  'task_complete_makeIt_unComplete_toChange_date'));
                          // showAlertDialog(context,
                          //     'Task is Completed ,Make it UnComplated to change Date');
                        } else {
                          if (dateprovEditOutFormat.year == datenow.year &&
                              dateprovEditOutFormat.month == datenow.month &&
                              (dateprovEditOutFormat.day >= datenow.day)) {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2050))
                                .then((value) => context
                                    .read<EditTaskProvider>()
                                    .changeDateEditProv(
                                        value ?? DateTime.now()));
                          } else {
                            showToastMessageAbimation(
                                context: context,
                                textToast: provLang.getText(
                                    'date_become_past_cant_change-it'));
                            // showAlertDialog(context,
                            //     'The date become past ,You can`t change it');
                          }
                        }
                      } catch (e) {
                        showToastMessageAbimation(
                            context: context, textToast: 'Error is $e');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey.shade400
                                  : const Color(0xff22262f).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(9.r)),
                      width: medQryWidth * 0.37,
                      height: medQryHeight * 0.2,
                      child: Center(
                        child: SizedBox(
                          width: medQryWidth * 0.25,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: SizedBox(
                              width: medQryWidth * 0.3,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Center(
                                  child: Text(
                                    provLang.isEn
                                        ? '${context.watch<EditTaskProvider>().dateTextEditProMonth}/${context.watch<EditTaskProvider>().dateTextEditProToday}/ ${context.watch<EditTaskProvider>().dateTextEditProYear}'
                                        : '${context.watch<EditTaskProvider>().dateTextEditProToday}\\${context.watch<EditTaskProvider>().dateTextEditProMonth}\\${context.watch<EditTaskProvider>().dateTextEditProYear}',
                                    style: TextStyle(fontSize: 17.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Divider(
                height: medQryHeight * 0.01,
                indent: medQryWidth * 0.05,
                endIndent: medQryWidth * 0.05,
                color: Colors.white,
              ),
              buildListTile(
                  leadIcons: Icons.delete_forever,
                  titleList: provLang.getText('delete_task_edit_task'),
                  widgetList: TextButton(
                      onPressed: () {
                        try {
                          final dateprovEditOutFormat = context
                              .read<EditTaskProvider>()
                              .dateeOutFormatEdit;
                          final datenow = DateTime.now();
                          if (dateprovEditOutFormat.year == datenow.year &&
                              dateprovEditOutFormat.month == datenow.month &&
                              (dateprovEditOutFormat.day >= datenow.day)) {
                            if (isComplated == 1) {
                              sumAndMinusProgress(context, false, taskAchive);
                            }
                            context.read<HomeProvider>().deleteTask(deleteTask);
                            Navigator.pop(context);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => const HomeNav()));
                          } else {
                            showToastMessageAbimation(
                                context: context,
                                textToast: provLang.getText(
                                    'date_become_past_cant_delete-it'));
                            // showAlertDialog(context,
                            //     'The date become past ,You can`t delete it');
                          }
                        } catch (e) {
                          showToastMessageAbimation(
                              context: context, textToast: 'Error is $e');
                        }
                      },
                      child: Container(
                        width: medQryWidth * 0.15,
                        height: medQryHeight * 0.04,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(9.r)),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Text(
                              provLang.getText('delete_btn_edit_task'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ))),
            ],
          ),
        )),
      ),
    );
  }

  buildListTile(
      {required IconData leadIcons,
      required String titleList,
      required Widget widgetList}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading: Icon(leadIcons),
      title:
          // FittedBox(
          //   child: FittedBox(
          //     child:
          SizedBox(
        child: SingleChildScrollView(
          child: Text(
            titleList,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      //   ),
      // ),
      trailing: widgetList,
    );
  }
}

class BuildTextFields extends StatefulWidget {
  const BuildTextFields(
      {Key? key, required this.task, required this.achivement})
      : super(key: key);
  final String task;
  final String achivement;

  @override
  State<BuildTextFields> createState() => _BuildTextFieldsState();
}

class _BuildTextFieldsState extends State<BuildTextFields> {
  // final TextEditingController _controllerTask = TextEditingController();
  // final TextEditingController _controllerAchivement = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<EditTaskProvider>().controllerTask.text = widget.task;
    context.read<EditTaskProvider>().controllerAchivement.text =
        widget.achivement;
  }

  @override
  Widget build(BuildContext context) {
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          minLines: 1,
          maxLines: 9,
          maxLength: 350,
          controller: context.read<EditTaskProvider>().controllerTask,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
        SizedBox(
          height: medQryHeight * 0.03,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 75.w, left: 75.w),
            child: TextFormField(
              minLines: 1,
              maxLines: 1,
              maxLength: 3,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
              controller: context.read<EditTaskProvider>().controllerAchivement,
              enabled:
                  (context.read<EditTaskProvider>().dateeOutFormatEdit.year ==
                              DateTime.now().year &&
                          context
                                  .read<EditTaskProvider>()
                                  .dateeOutFormatEdit
                                  .month ==
                              DateTime.now().month &&
                          (context
                                  .read<EditTaskProvider>()
                                  .dateeOutFormatEdit
                                  .day >=
                              DateTime.now().day))
                      ? true
                      : false,
              decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                // enabledBorder: OutlineInputBorder,
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.red, width: 5.0),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  // borderSide: BorderSide(color: Colors.amber)
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
