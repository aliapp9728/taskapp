import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';

import '../../controller/prov_homepage.dart';
import '../../core/app_color.dart';

class AllAchievment extends StatelessWidget {
  const AllAchievment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    bool isModLight = Theme.of(context).brightness == Brightness.light;
    return Directionality(
      textDirection: provLang.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor:
            isModLight ? AppColor.minColor : const Color(0xff22262f),
        appBar: AppBar(
          backgroundColor:
              isModLight ? AppColor.minColor : const Color(0xff22262f),
          title: FittedBox(
              child: Text(provLang.getText('title_acheivement_days'))),
          centerTitle: true,
        ),
        body: Container(
          height: 10000.h,
          color: isModLight
              ? const Color.fromARGB(255, 197, 233, 233)
              : const Color(0xff424F64),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.h,
                ),
              ),

              // No Need
              methodSliverList(context),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  methodSliverList(BuildContext context) {
    var provLang = context.watch<ProvLanguge>();
    bool isModLight = Theme.of(context).brightness == Brightness.light;
    var textStyle = TextStyle(
      color: Colors.grey[200],
    );
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var readHomeProv = context.read<HomeProvider>();
          var progressList = readHomeProv.progressList[index];
          // will just put a condition if they were the same date will show it
          if (readHomeProv.progressList.isNotEmpty) {
            return Column(
              children: [
                Container(
                  width: 350.w,
                  height: 80.h,
                  padding: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color: isModLight
                          ? AppColor.minColor
                          : const Color(0xff22262f),
                      borderRadius: BorderRadius.circular(90)),
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

                              // backgroundColor: const Color(0xff424F64),
                              lineHeight: 30.h,
                              barRadius: Radius.circular(30.r),
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              center: FittedBox(
                                child: Text(
                                    '${(progressList.progressOfDay! * 100).toStringAsFixed(1)} %'),
                              ),
                            )
                          : Container(
                              width: 150.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    provLang.getText('lis_prog_take_rest'),
                                    style: textStyle,
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
                              ? '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressYear} - ${progressList.dateProgressmonth} - ${progressList.dateProgressToday}'
                              : '${provLang.getText('lis_prog_date_halfMonth')} ${progressList.dateProgressToday} - ${progressList.dateProgressmonth} - ${progressList.dateProgressYear}',
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
        childCount: context.read<HomeProvider>().progressList.length,
      ),
    );
  }
}
