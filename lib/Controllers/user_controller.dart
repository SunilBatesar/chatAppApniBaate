import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:recipe_test/Data/Network/networkapi_service.dart';
import 'package:recipe_test/Models/firebase_response_model.dart';
import 'package:recipe_test/Models/user_model.dart';
import 'package:recipe_test/Utils/Enums/enums.dart';
import 'package:recipe_test/Utils/routes/routes_name.dart';
import 'package:recipe_test/main.dart';

class UserController extends GetxController {
  final _service = NetworkapiService();
  dynamic _userdata;
  UserModel get userdata => _userdata;

  Future<void> getDataUser(String id) async {
    try {
      final response = await _service.get(constantSheet.apis.userDocument(id))
          as FirebaseResponseModel;
      if (response.docId.isNotEmpty) {
        _userdata = UserModel.fromjson(response);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signup(Map<String, dynamic> jsondata) async {
    final uData =
        UserModel.fromjson(FirebaseResponseModel(jsondata["user"], ""));
    try {
      UserCredential userCredential = await _service.authenticate(
              state: AuthState.SIGNUP,
              json: {"email": uData.email, "password": jsondata["password"]})
          as UserCredential;
      var id = userCredential.user!.uid;
      if (id.isNotEmpty) {
        await _service.post(constantSheet.apis.userDocument(id), uData.tomap());
        await prefs.setSharedPrefs(prefs.userKey, id);
        _userdata = uData.copyWith(id: id);
        Get.offNamed(RouteName.homeScreen); // NEXT SCREEN
      }
    } catch (e) {
      print(e.toString());
    } finally {
      update();
    }
  }

  Future<void> login(Map<String, dynamic> json) async {
    String email = json["email"];
    String password = json["password"];
    try {
      final snapshot = await _service.get(
              constantSheet.apis.userReference.where("email", isEqualTo: email))
          as List<FirebaseResponseModel>;
      if (snapshot.first.docId.isNotEmpty) {
        UserModel data = UserModel.fromjson(
            snapshot.first); // USER DATA CONVERT TO USER MODEL
        await _service.authenticate(
            state: AuthState.LOGIN,
            json: {"email": data.email, "password": password});
        await prefs.setSharedPrefs(prefs.userKey,
            snapshot.first.docId); // SET USER ID SharedPreferences
        _userdata = data; // SET DATA
        Get.offNamed(RouteName.homeScreen); // NEXT SCREEN
      }
    } catch (e) {
      print(e.toString());
    } finally {
      update();
    }
  }

  // LOGOUT
  Future<void> logout() async {
    print(prefs.getSharedPrefs(prefs.userKey));
    try {
      await _service.authenticate(state: AuthState.LOGOUT);

      prefs.removSharedPrefs(prefs.userKey);
      Get.offAllNamed(RouteName.loginScreen);
    } catch (e) {
      print(e.toString());
    }
  }
}
