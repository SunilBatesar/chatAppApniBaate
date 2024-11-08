import 'package:recipe_test/Utils/Enums/enums.dart';

class ChatModel {
  String? id;
  String? senderid;
  String? data;
  ChatTypes? typevalue;
  DateTime? time;
  bool? messagesStatus;

  ChatModel({
    this.id,
    this.senderid,
    this.data,
    this.typevalue,
    this.time,
    this.messagesStatus,
  });

  ChatModel copyWith({
    String? id,
    String? senderid,
    String? data,
    ChatTypes? typevalue,
    bool? messagesStatus,
    DateTime? time,
  }) {
    return ChatModel(
        id: id ?? this.id,
        senderid: senderid ?? this.senderid,
        data: data ?? this.data,
        typevalue: typevalue ?? this.typevalue,
        messagesStatus: messagesStatus ?? this.messagesStatus,
        time: time ?? this.time);
  }

  Map<String, dynamic> toMap() {
    return {
      "senderid": senderid ?? "",
      "data": data ?? "",
      "typevalue": typevalue!.name,
      "messagesStatus": messagesStatus ?? false,
      "time": DateTime.now().toString()
    };
  }

  ChatModel.fromejson(Map<Object?, Object?> json, String iD)
      : id = iD.toString(),
        senderid = (json["senderid"] ?? "").toString(),
        data = (json["data"] ?? "").toString(),
        typevalue = ChatTypes.values.firstWhere(
            (element) => element.name == (json["typevalue"] ?? "").toString(),
            orElse: () => ChatTypes.MESSAGE),
        messagesStatus = (json["messagesStatus"] ?? false) as bool,
        time = DateTime.parse((json["time"] ?? "").toString());
}
