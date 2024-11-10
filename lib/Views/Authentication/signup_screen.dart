import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Components/Buttons/primary_button.dart';
import 'package:recipe_test/Components/TextFields/primary_text_form_field.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Services/appconfig.dart';
import 'package:recipe_test/Utils/app_validators.dart';
import 'package:recipe_test/Utils/routes/routes_name.dart';
import 'package:recipe_test/main.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final Rx<bool> passwordShow = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantSheet.colors.bg,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(TextSpan(
                        text: "Sign up to",
                        style: constantSheet.textTheme.fs20Medium,
                        children: <TextSpan>[
                          TextSpan(
                              text: " ${AppConfig.appName}",
                              style: constantSheet.textTheme.fs24Medium
                                  .copyWith(
                                      color: constantSheet.colors.primary))
                        ])),
                  ),
                  Gap(5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign up and start your journey",
                      style: constantSheet.textTheme.fs14Normal
                          .copyWith(color: constantSheet.colors.graylight),
                    ),
                  ),
                  Gap(20.h),
                  Form(
                      key: _key,
                      child: Column(
                        children: [
                          PrimaryTextFormField(
                            hinttext: "Name",
                            controller: _nameController,
                            validator: TextValidator(),
                          ),
                          Gap(18.h),
                          PrimaryTextFormField(
                            hinttext: "User Name",
                            controller: _usernameController,
                            validator: TextValidator(),
                          ),
                          Gap(18.h),
                          PrimaryTextFormField(
                            hinttext: "Email",
                            controller: _emailController,
                            validator: EmailValidator(),
                          ),
                          Gap(18.h),
                          Obx(
                            () => PrimaryTextFormField(
                              hinttext: "Password",
                              controller: _passwordController,
                              validator: PasswordValidator(),
                              obscureText: passwordShow.value,
                              suffixiconOnTap: () {
                                passwordShow.value = !passwordShow.value;
                              },
                              suffixicon: passwordShow.value == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          )
                        ],
                      )),
                  Gap(45.h),
                  GetBuilder<UserController>(
                    builder: (controller) => PrimaryButton(
                      title: "Sign Up",
                      isExpanded: true,
                      isloading: controller.loading,
                      onPressed: () async {
                        await _getValideTextField();
                      },
                    ),
                  ),
                  Gap(25.h),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(RouteName.loginScreen);
                    },
                    child: Text.rich(TextSpan(
                        text: "Have an account? ",
                        style: constantSheet.textTheme.fs16Normal,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login now",
                              style: TextStyle(
                                  color: constantSheet.colors.primary))
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getValideTextField() async {
    final userController = Get.find<UserController>();
    if (_key.currentState!.validate()) {
      final user = UserModel(
        userName: _usernameController.text.trim(),
        name: _nameController.text,
        email: _emailController.text.trim(),
        inactiveTime: DateTime.now(),
        status: true,
      ).tomap();
      await userController.signup({
        "user": user,
        "password": _passwordController.text.trim(),
      });
    }
  }
}
