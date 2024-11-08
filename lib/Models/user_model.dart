import 'package:recipe_test/Models/firebase_response_model.dart';

class UserModel {
  String? id, name, email;
  String? userName;
  bool? status;
  List<String>? chatRoomIds;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.status,
    this.userName,
    this.chatRoomIds,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? userName,
    bool? status,
    List<String>? chatRoomIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      userName: userName ?? this.userName,
      chatRoomIds: chatRoomIds ?? this.chatRoomIds,
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "email": email ?? "",
      "name": name ?? "",
      "userName": userName ?? "",
      "status": status ?? true,
      "chatRoomIds": chatRoomIds ?? [],
    };
  }

  UserModel.fromjson(FirebaseResponseModel json)
      : id = json.docId,
        name = json.data["name"] ?? "",
        userName = json.data["userName"] ?? "",
        email = json.data["email"] ?? "",
        status = json.data["status"] ?? false,
        chatRoomIds = ((json.data["chatRoomIds"] ?? []) as List)
            .map((e) => e.toString())
            .toList();
}
