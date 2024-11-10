import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Models/firebase_response_model.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Views/Chat/chat_screen.dart';
import 'package:recipe_test/Views/Widgets/stream_builder_widget.dart';
import 'package:recipe_test/main.dart';

class UserTile extends StatelessWidget {
  final String id;
  final Function? tileOntap;
  UserTile({super.key, required this.id, this.tileOntap});
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget(
      stream: constantSheet.apis.userDocument(id).snapshots(),
      widget: (snapshot) {
        final db = UserModel.fromjson(
            FirebaseResponseModel.fromResponse(snapshot.requireData));
        return ListTile(
          onTap: () {
            Get.to(() => ChatScreen(model: db));
            tileOntap != null ? tileOntap!() : null;
          },
          contentPadding: const EdgeInsets.all(0),
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
                  placeholder: (context, url) => SizedBox(
                    height: 15.sp,
                    width: 15.sp,
                    child: CircularProgressIndicator(
                      color: constantSheet.colors.yellowlight,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              db.status!
                  ? Positioned(
                      right: -4,
                      bottom: 2,
                      child: Container(
                        height: 18.sp,
                        width: 18.sp,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: constantSheet.colors.white, width: 2.sp),
                            color: constantSheet.colors.green,
                            shape: BoxShape.circle),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          title: Text(db.name ?? "", style: constantSheet.textTheme.fs18Medium),
          subtitle: Text(
            "hello",
            style: constantSheet.textTheme.fs14Normal
                .copyWith(color: constantSheet.colors.graylight),
          ),
        );
      },
    );

    // StreamBuilder(
    //   stream: constantSheet.apis.userDocument(id).snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Align(
    //         alignment: Alignment.topCenter,
    //         child: CircularProgressIndicator(
    //           color: constantSheet.colors.yellowlight,
    //         ),
    //       ).marginOnly(top: 30.h);
    //     } else if (snapshot.connectionState == ConnectionState.active ||
    //         snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
    //         final db = UserModel.fromjson(
    //             FirebaseResponseModel.fromResponse(snapshot.requireData));
    //         return ListTile(
    //           onTap: () {
    //             Get.to(() => ChatScreen(model: db));
    //           },
    //           contentPadding: const EdgeInsets.all(0),
    //           leading: ClipRRect(
    //             borderRadius: BorderRadius.circular(1000),
    //             child: CachedNetworkImage(
    //               height: 50,
    //               width: 50,
    //               fit: BoxFit.cover,
    //               imageUrl:
    //                   "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
    //               placeholder: (context, url) => SizedBox(
    //                 height: 15.sp,
    //                 width: 15.sp,
    //                 child: CircularProgressIndicator(
    //                   color: constantSheet.colors.yellowlight,
    //                 ),
    //               ),
    //               errorWidget: (context, url, error) => const Icon(Icons.error),
    //             ),
    //           ),
    //           title: Text(db.name ?? "",
    //               style: constantSheet.textTheme.fs18Medium),
    //           subtitle: Text(
    //             db.status! ? "Online" : "Ofline",
    //             style: constantSheet.textTheme.fs14Normal
    //                 .copyWith(color: constantSheet.colors.graylight),
    //           ),
    //         );
    //       } else {
    //         return const SizedBox();
    //       }
    //     } else {
    //       return const SizedBox();
    //     }
    //   },
    // );
  }
}
