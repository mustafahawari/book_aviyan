import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class FirebaseService {
  FirebaseFirestore _firestore;
  FirebaseService(this._firestore);
  Future<void> update(String collection,{required
      Map<String, dynamic> data , required String docId}) async {
    return await _firestore.collection(collection).doc(docId).set(data);
  }
}
