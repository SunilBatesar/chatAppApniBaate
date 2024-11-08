import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Data/Functions/functions.dart';
import 'package:recipe_test/Models/chat_model.dart';

class ChatsController extends GetxController {
  final _database = FirebaseDatabase.instance;

  Future setChat(String userId2, ChatModel model) async {
    final userController = Get.find<UserController>();
    String chatRoomId =
        AppFunctions.chatRoomId(userController.userdata.id!, userId2);
    try {
      await _database.ref("chats").child(chatRoomId).push().set(model.toMap());
      List<String> usersId = [userController.userdata.id!, userId2];
      for (var element in usersId) {
        await userController.addChateRoomId(element, chatRoomId);
      }
    } catch (e) {
      print("Set DataBase data :: ${e.toString()}");
    }
  }

  getdata() async {
    try {
      final response = await _database.ref("chats").child("123456789").get();
      print(response.value);
    } catch (e) {
      print("Get DataBase data :: ${e.toString()}");
    }
  }
}
