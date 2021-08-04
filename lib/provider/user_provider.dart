import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAuthenticated = false;

  Future<void> userData() async {
    if (_auth.currentUser != null) {
      isAuthenticated = true;
      User _user = _auth.currentUser!;
      var _uid = _user.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(_uid).get();

      name = userDoc.get("name");
      email = userDoc.get("email");
      phoneNumber = userDoc.get("phoneNumber");
      imageUrl = userDoc.get("imageUrl");
    } else {
      isAuthenticated = false;
    }
    notifyListeners();
  }
}
