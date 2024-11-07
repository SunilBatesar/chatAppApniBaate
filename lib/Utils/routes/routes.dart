import 'package:get/get.dart';
import 'package:recipe_test/Views/Authentication/login_screen.dart';
import 'package:recipe_test/Views/Authentication/signup_screen.dart';
import 'package:recipe_test/Views/home/home_screen.dart';
import 'package:recipe_test/Utils/routes/routes_name.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: RouteName.signUpScreen, page: () => SignupScreen()),
  GetPage(name: RouteName.loginScreen, page: () => LoginScreen()),
  GetPage(name: RouteName.homeScreen, page: () => const HomeScreen()),
];
