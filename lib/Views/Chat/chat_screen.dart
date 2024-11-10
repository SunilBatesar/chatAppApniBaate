import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Components/TextFields/message_textfield.dart';
import 'package:recipe_test/Controllers/chats_controller.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Data/Functions/functions.dart';
import 'package:recipe_test/Models/chat_model.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Utils/Enums/enums.dart';
import 'package:recipe_test/Views/Chat/Widgets/chat_ui.dart';
import 'package:recipe_test/main.dart';

class ChatScreen extends StatefulWidget {
  final UserModel model;
  const ChatScreen({super.key, required this.model});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageFieldcontroller = TextEditingController();
  String chatroom = "";
  final userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    chatroom =
        AppFunctions.chatRoomId(userController.userdata.id!, widget.model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantSheet.colors.primary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: constantSheet.colors.white,
            )),
        title: Text(widget.model.name ?? "",
            style: constantSheet.textTheme.fs24Normal
                .copyWith(color: constantSheet.colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0.sp),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref("chats").child(chatroom),
                itemBuilder: (context, snapshot, animation, index) {
                  final data = ChatModel.fromejson(
                      snapshot.value! as Map<Object?, Object?>, snapshot.key!);
                  if (widget.model.id == data.senderid) {
                    return Align(
                        alignment: Alignment.centerLeft,
                        child: chatUi(data.typevalue!, data.data!)
                            .marginOnly(bottom: 10.h));
                  } else {
                    return Align(
                        alignment: Alignment.centerRight,
                        child: chatUi(data.typevalue!, data.data!)
                            .marginOnly(bottom: 10.h));
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MessageTextfield(
        controller: messageFieldcontroller,
        onFieldSubmitted: () async {
          await chatHandleFunction();
        },
      ),
    );
  }

  Future<void> chatHandleFunction() async {
    final userController = Get.find<UserController>();
    final chat = ChatModel(
      senderid: userController.userdata.id,
      data: messageFieldcontroller.text,
      typevalue: ChatTypes.MESSAGE,
    );
    final String chatRoomId =
        AppFunctions.chatRoomId(userController.userdata.id!, widget.model.id!);
    bool chatbool =
        widget.model.chatRoomIds!.any((element) => element == chatRoomId);
    if (chat.data == null || chat.data!.isNotEmpty) {
      await ChatsController().setChat(chatRoomId, chat, chatbool);
      messageFieldcontroller.clear();
    }
  }
}
