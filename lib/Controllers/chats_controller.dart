import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Controllers/user_controller.dart';
import 'package:recipe_test/Models/chat_model.dart';

class ChatsController extends GetxController {
  final _database = FirebaseDatabase.instance;

  Future setChat(String chatRoomId, ChatModel model, bool chatbool) async {
    final userController = Get.find<UserController>();
    try {
      await _database.ref("chats").child(chatRoomId).push().set(model.toMap());
      if (!chatbool) {
        List<String> usersId = chatRoomId.split("-");
        for (var id in usersId) {
          await userController.addChateRoomId(id, chatRoomId);
        }
      }
    } catch (e) {
      print("Set DataBase data :: ${e.toString()}");
    }
  }
}
