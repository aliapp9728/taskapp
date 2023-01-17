import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskjob_aliapp/controller/prov_calendar.dart';
import 'package:taskjob_aliapp/controller/prov_languge.dart';
import 'controller/drawer_prov/prov_achive_repport.dart';
import './controller/prov_edit_task.dart';
import './controller/theme_provider.dart';
import './db_helper/dbhelper.dart';
import './controller/prov_homepage.dart';
import 'view/home_page.dart';

bool currentThemeProv = true;
bool isTodayBreak = false;
void main() async {
  await initializeDateFormatting("ar_SA", null);
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  currentThemeProv = prefs.getBool('theme') ?? true;
  isTodayBreak = prefs.getBool('isTodayBreak') ?? false;

  if (currentThemeProv) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  if (!currentThemeProv) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xff22262f),
        systemNavigationBarIconBrightness: Brightness.light));
  }

  await DbHelper.initDatabase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProviderClass()),
      ChangeNotifierProvider(create: (_) => EditTaskProvider()),
      ChangeNotifierProvider(create: (_) => AcheiveReportProv()),
      ChangeNotifierProvider(create: (_) => ProvCalendar()),
      ChangeNotifierProvider(create: (_) => ProvLanguge()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));
    return ScreenUtilInit(
      builder: (_, widget) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: context.watch<ThemeProviderClass>().themeMode,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
      designSize: const Size(360, 690),
    );
  }

  onAfterBuild(BuildContext context) async {
    context.read<HomeProvider>().getProgress();
    context.read<HomeProvider>().getTask();
    final prefs = await SharedPreferences.getInstance();
    bool newValue = prefs.getBool('lang') ?? true;
    // ignore: use_build_context_synchronously
    context.read<ProvLanguge>().changeLanguage(newValue);
  }
}
