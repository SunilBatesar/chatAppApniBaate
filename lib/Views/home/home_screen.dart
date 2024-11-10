import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Components/TextFields/search_text_form_field.dart';
import 'package:recipe_test/Components/Tiles/user_tile.dart';
import 'package:recipe_test/Controllers/chats_controller.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Models/firebase_response_model.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Services/appconfig.dart';
import 'package:recipe_test/Utils/utils.dart';
import 'package:recipe_test/Views/Widgets/stream_builder_widget.dart';
import 'package:recipe_test/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final userController = Get.find<UserController>();
  final chatsController = Get.find<ChatsController>();
  final searchController = TextEditingController();

  String searchUserData = "";
  final searchfocusNode = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      await userController.updateUserStatus(true, DateTime.now());
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      await userController.updateUserStatus(false, DateTime.now());
    } else if (state == AppLifecycleState.detached) {
      await userController.updateUserStatus(false, DateTime.now());
    }
  }

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
                child: Column(children: [
                  SearchTextFormField(
                      focusNode: searchfocusNode,
                      hinttext: "Search user name",
                      controller: searchController,
                      iconOnTap: () async {
                        if (userController.userdata.userName !=
                            searchController.text.trim()) {
                          final data = await userController
                              .searchuser(searchController.text.trim());
                          if (data.isNotEmpty) {
                            searchUserData = data;
                            searchController.clear();
                            searchfocusNode.unfocus();
                            setState(() {});
                          } else {
                            return AppUtils.messageSnakeBar(
                                "No!", "User found");
                          }
                        }
                      }),
                  searchUserData.isNotEmpty
                      ? UserTile(
                          id: searchUserData,
                          tileOntap: () {
                            searchUserData = "";
                            setState(() {});
                          },
                        )
                      : StreamBuilderWidget(
                          stream: constantSheet.apis
                              .userDocument(userController.userdata.id!)
                              .snapshots(),
                          widget: (snapshot) {
                            final chatRoomids = UserModel.fromjson(
                                    FirebaseResponseModel.fromResponse(
                                        snapshot.requireData))
                                .chatRoomIds;
                            List<String> ids = [];
                            for (var element in chatRoomids!) {
                              final id = element.split("-");
                              id.removeWhere(
                                  (e) => e == userController.userdata.id);
                              if (id.isNotEmpty) {
                                ids.add(id[0]);
                              }
                            }
                            return ListView.builder(
                                itemCount: ids.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return UserTile(
                                    id: ids[index],
                                    tileOntap: () {
                                      searchfocusNode.unfocus();
                                    },
                                  );
                                });
                          },
                        )
                ]))));
  }
}
