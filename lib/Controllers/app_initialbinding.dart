import 'package:get/get.dart';
import 'package:recipe_test/Controllers/user_controller.dart';

class AppInitialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
