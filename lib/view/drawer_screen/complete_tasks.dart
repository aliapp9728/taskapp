import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';

import '../../core/app_color.dart';
import '../../core/method.dart';
import '../../controller/prov_homepage.dart';
import '../../widget/theme.dart';

class Completedtasks extends StatelessWidget {
  const Completedtasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    Size medQry = MediaQuery.of(context).size;
    double medQryHeight = medQry.height;
    double medQryWidth = medQry.width;
    return Directionality(
      textDirection: provLang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? AppColor.minColor
            : const Color(0xff22262f),
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.minColor
              : const Color(0xff22262f),
          title:
              FittedBox(child: Text(provLang.getText('title_completed_tasks'))),
          centerTitle: true,
        ),
        body: Container(
          height: medQryHeight,
          color: Theme.of(context).brightness == Brightness.light
              ? const Color.fromARGB(255, 197, 233, 233)
              : const Color(0xff424F64),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            // reverse: true,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.h,
                ),
              ),
              // ignore: prefer_const_constructors
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var task = context.read<HomeProvider>().taskList[index];

                    if (task.isCompleted == 1
                        // )
                        ) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: GestureDetector(
                              onTap: () {
                                try {} catch (e) {
                                  showToastMessageAbimation(
                                      context: context,
                                      textToast: 'Error is $e');
                                }
                              },
                              child: Container(
                                width: medQryWidth * 0.93,
                                height: medQryHeight * 0.1,
                                // padding: EdgeInsets.only(left: 10.w),
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
                                  minLeadingWidth: 10.w,
                                  trailing: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 6.w),
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
                                  contentPadding:
                                      EdgeInsets.only(right: 10.w, left: 10.w),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      right: 5.w,
                                      bottom: 1.h,
                                      top: 15.h,
                                    ),
                                    // child: FittedBox(
                                    child: Text('${task.task}',
                                        style: subHeadingStyle.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color: const Color.fromARGB(
                                                255, 44, 43, 43))),
                                    // ),
                                  ),
                                  subtitle:
                                      //  FittedBox( child:
                                      Text(
                                    provLang.isEn
                                        ? '${task.dateMonthTask}/${task.dateTodayTask}/${task.dateYearTask}'
                                        : '${task.dateYearTask}/${task.dateMonthTask}/${task.dateTodayTask}',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 10.sp,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // ),
                                  horizontalTitleGap: 5,
                                  leading: Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                        activeColor: const Color.fromARGB(
                                            243, 157, 245, 69),
                                        // const Color.fromARGB(255, 52, 250, 62),
                                        shape: const CircleBorder(),
                                        onChanged: (_) {},
                                        value: task.isCompleted == 1
                                            ? true
                                            : false,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          // ),
                        ],
                      );
                    } else {
                      return Container(
                        color: Colors.amber[600],
                      );
                    }
                  },
                  childCount: context.read<HomeProvider>().taskList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60.h,
                ),
              ),
              // SizedBox(
              //   height: 100.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
