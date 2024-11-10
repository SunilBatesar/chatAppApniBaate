import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_test/Utils/Enums/enums.dart';
import 'package:recipe_test/main.dart';

Widget chatUi(ChatTypes type, String value) {
  switch (type) {
    case ChatTypes.MESSAGE:
      return Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: constantSheet.colors.yellowlight,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(value,
            style: constantSheet.textTheme.fs16Normal
                .copyWith(color: constantSheet.colors.black)),
      );
    default:
      return const SizedBox();
  }
}

