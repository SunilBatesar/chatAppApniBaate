import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Apis {
  final _firestore = FirebaseFirestore.instance;
  final _database = FirebaseDatabase.instance;

  CollectionReference<Map<String, dynamic>> get userReference =>
      _firestore.collection("users");

  DocumentReference<Map<String, dynamic>> userDocument(String id) =>
      userReference.doc(id);

  DatabaseReference chats(String child) => _database.ref("Chats").child(child);
}
