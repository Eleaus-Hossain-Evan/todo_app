import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/database_helper_controller.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/views/onboarding/onboarding_page.dart';
import 'package:todo_app/views/theme/theme.dart';

import 'controller/shared_preference_controller.dart';
import 'views/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KSharedPreference.init();
  DbController.instance().initializeDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  bool isNew = false;

  @override
  Widget build(BuildContext context) {
    final KSharedPreference _pref = Get.put(KSharedPreference());
    final HomeController _home = Get.put(HomeController());
    final DbController _db = Get.put(DbController.instance());
    final isNew = _pref.getBool(_pref.isNew) ?? true;
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: const MaterialColor(0xFF1191E3, KTheme.mapColor),
          ),
          // home: isNew ? OnboardingPage() : HomePage(),
          home: HomePage(),
          builder: (context, child) {
            child = MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
            return child;
          },
        );
      },
    );
  }
}
