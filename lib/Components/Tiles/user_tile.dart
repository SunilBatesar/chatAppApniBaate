import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Views/Chat/chat_screen.dart';
import 'package:recipe_test/main.dart';

class UserTile extends StatelessWidget {
  final UserModel model;
  const UserTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => ChatScreen(model: model));
      },
      contentPadding: const EdgeInsets.all(0),
      leading: ClipRRect(
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
      title: Text(model.name ?? "", style: constantSheet.textTheme.fs18Medium),
      subtitle: Text(
        model.status! ? "Online" : "Ofline",
        style: constantSheet.textTheme.fs14Normal
            .copyWith(color: constantSheet.colors.graylight),
      ),
    );
  }
}
