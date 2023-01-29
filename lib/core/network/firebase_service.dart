import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> update(String collection,{required
      Map<String, dynamic> data , required String docId}) async {
    return await _firestore.collection(collection).doc(docId).set(data);
  }
}
