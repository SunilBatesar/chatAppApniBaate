import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:recipe_test/main.dart';

class MessageTextfield extends StatefulWidget {
  final Function onFieldSubmitted;
  final TextEditingController controller;
  const MessageTextfield(
      {super.key, required this.onFieldSubmitted, required this.controller});

  @override
  State<MessageTextfield> createState() => _MessageTextfieldState();
}

class _MessageTextfieldState extends State<MessageTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        width: constantSheet.services.screenWidth(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.add,
                size: 30.sp,
                color: constantSheet.colors.graylight,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                onFieldSubmitted: (value) {
                  widget.onFieldSubmitted();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: constantSheet.colors.lightblue))),
              ),
            ),
            Gap(10.w),
            GestureDetector(
              onTap: () {
                widget.onFieldSubmitted();
              },
              child: Container(
                width: 50.sp,
                height: 50.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: constantSheet.colors.primary,
                ),
                child: Center(
                  child: Icon(
                    Icons.send,
                    size: 30.sp,
                    color: constantSheet.colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ).paddingOnly(bottom: 10.h),
    );
  }
}
