import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskjob_aliapp/view/calender_screen.dart';
import 'package:taskjob_aliapp/view/homae_navigator.dart';

import '../core/method.dart';
import '../controller/prov_homepage.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    // LocalNotification.init(context: context, initSchedlue: true);
    // // if (LocalNotification().initCheck) {
    // LocalNotification().showScheduleNotification(
    //     // schedlueDate: DateTime.now().add(const Duration(seconds: 4)),
    //     schedlueDate: 10,
    //     minut: 30,
    //     title: 'Ali',
    //     body: 'You stupid idiot',
    //     payload: 'You are happy now , aren`t you ?');
    // // }
  }

  @override
  Widget build(BuildContext context) {
    var medQry = MediaQuery.of(context).size;
    var medQryHieght = medQry.height;
    var medQryWidth = medQry.width;
    // ScreenUtil.init(context, designSize: const Size(360, 690));
    ScreenUtil.init(context, designSize: Size(medQryWidth, medQryHieght));
    final watchProvHome = context.watch<HomeProvider>();

    final readProvHome = context.read<HomeProvider>();

    final screens = [
      const CalenderScreen(),
      const HomeNav(),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldState,
        drawer: const DrawePage(),
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xff22262f),
          index: watchProvHome.page,
          height: 50.h,
          buttonBackgroundColor:
              Theme.of(context).brightness == Brightness.light
                  ? const Color(0xffF9FFFF)
                  : const Color(0xff22262f),
          backgroundColor: watchProvHome.changeColor == 0
              ? Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 238, 247, 247)
                  : const Color(0xff424F64)
              : Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 197, 233, 233)
                  : const Color(0xff424F64),
          items: [
            Icon(Icons.calendar_month_outlined, size: 30.h, color: Colors.red),
            Icon(
              Icons.home_outlined,
              size: 40.h,
              color: Colors.blue.shade700,
            ),
            Icon(
              Icons.menu_rounded,
              size: 30.h,
              color: Colors.red,
            ),
          ],
          onTap: (index) {
            try {
              // var qryHieght = MediaQuery.of(context).size.height;
              // var qryWidth = MediaQuery.of(context).size.width;
              // print(
              //     'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \n \n');
              // print('Height  is $qryHieght \n \n');
              // print(
              //     'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \n \n');
              // print('Width  is  $qryWidth \n \n');
              // print(
              //     'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \n \n');
              readProvHome.changeChangeColor(index);
              if (index != 2) {
                readProvHome.changePage(index);
              }
              if (index == 2) {
                readProvHome.changePage(1);
                scaffoldState.currentState!.openDrawer();
              }
              if (index == 1) {
                context.read<HomeProvider>().getTask();
                context.read<HomeProvider>().getProgress();
              }
            } catch (e) {
              showToastMessageAbimation(
                  context: context, textToast: 'Error is $e');
            }
          },
        ),
        body: screens[watchProvHome.page]);
  }
}
