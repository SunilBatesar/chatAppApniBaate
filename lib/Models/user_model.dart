

import 'package:recipe_test/Models/firebase_response_model.dart';

class UserModel {
  String? id, name, email;
  UserModel({this.id, this.name, this.email});

  UserModel copyWith({
    String? id,
    name,
    email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> tomap() {
    return {"email": email ?? "", "name": name ?? ""};
  }

  UserModel.fromjson(FirebaseResponseModel json)
      : id = json.docId,
        name = json.data["name"],
        email = json.data["email"];
}
