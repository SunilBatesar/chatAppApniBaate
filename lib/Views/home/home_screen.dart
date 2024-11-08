import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Components/TextFields/search_text_form_field.dart';
import 'package:recipe_test/Components/Tiles/user_tile.dart';
import 'package:recipe_test/Controllers/chats_controller.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Services/appconfig.dart';
import 'package:recipe_test/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userController = Get.find<UserController>();
  final chatsController = Get.find<ChatsController>();
  final searchController = TextEditingController();

  UserModel? searchUserData;

  @override
  Widget build(BuildContext context) {
    print(userController.userdata.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantSheet.colors.primary,
        title: Text(AppConfig.appName,
            style: constantSheet.textTheme.fs24Normal
                .copyWith(color: constantSheet.colors.white)),
        actions: [
          IconButton(
              onPressed: () async {
                userController.logout();
              },
              icon: Icon(
                Icons.login_outlined,
                size: 24.sp,
                color: constantSheet.colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              SearchTextFormField(
                  hinttext: "Search user name",
                  controller: searchController,
                  iconOnTap: () async {
                    if (userController.userdata.userName !=
                        searchController.text.trim()) {
                      final data = await userController
                          .searchuser(searchController.text.trim());
                      searchUserData = data;
                      setState(() {});
                    }
                  }),
              searchUserData != null
                  ? UserTile(model: searchUserData!)
                  : GetBuilder<UserController>(
                      builder: (controller) {
                        return ListView.builder(
                          itemCount: controller.friendsdata.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return UserTile(
                                model: controller.friendsdata[index]);
                          },
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
