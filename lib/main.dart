import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Classes/constant_sheet.dart';
import 'package:recipe_test/Controllers/app_initialbinding.dart';
import 'package:recipe_test/Preferences/sharedpreferences.dart';
import 'package:recipe_test/Services/appconfig.dart';
import 'package:recipe_test/Utils/routes/routes.dart';
import 'package:recipe_test/Utils/routes/routes_name.dart';
import 'package:recipe_test/firebase_options.dart';

late ConstantSheet constantSheet;
SharedPrefs prefs = SharedPrefs.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await prefs.getpref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        constantSheet = ConstantSheet.instance;
        return GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          getPages: routes,
          initialRoute: RouteName.splashScreen,
          initialBinding: AppInitialbinding(),
        );
      },
      designSize: Size(AppConfig.screenWidth, AppConfig.screenHeight),
    );
  }
}
