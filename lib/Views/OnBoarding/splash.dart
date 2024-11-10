import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Services/appconfig.dart';
import 'package:recipe_test/Utils/routes/routes_name.dart';
import 'package:recipe_test/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    final userId = prefs.getSharedPrefs(prefs.userKey);
    final userController = Get.find<UserController>();
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (userId.isNotEmpty) {
        await userController.getDataUser(userId).then((v) async {
          Get.offNamed(RouteName.homeScreen);
        });
      } else {
        Get.offNamed(RouteName.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: constantSheet.services.screenHeight(context),
      width: constantSheet.services.screenWidth(context),
      decoration: BoxDecoration(color: constantSheet.colors.primary),
      child: Center(
        child: Text(AppConfig.appName,
            style: constantSheet.textTheme.fs35Medium
                .copyWith(color: constantSheet.colors.white)),
      ),
    ));
  }
}
