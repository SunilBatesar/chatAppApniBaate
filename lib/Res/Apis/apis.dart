import 'package:cloud_firestore/cloud_firestore.dart';

class Apis {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get userReference =>
      _firestore.collection("users");

  DocumentReference<Map<String, dynamic>> userDocument(String id) =>
      userReference.doc(id);


}
