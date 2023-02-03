import 'package:book_aviyan_final/core/consts/app_collections.dart';
import 'package:book_aviyan_final/core/network/firebase_service.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_model/admin_model.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUp(UserModel userModel, String password);
  Future<User?> signIn(String email, String password);

  Future<AdminUser?> adminLogin(String username, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore _firestore;
  final FirebaseService firebaseService;

  AuthRemoteDataSourceImpl(this.firebaseService, this.auth, this._firestore);
  @override
  Future<User?> signUp(UserModel userModel, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: userModel.email!, password: password);
      if (result.user != null) {
        saveUserInfoToDb(userModel, result.user!.uid);
      }
      return auth.currentUser;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return auth.currentUser;
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserInfoToDb(UserModel userModel, String docId) async {
    try {
      userModel.userId = docId;
      await firebaseService.update(
        AppCollections.USER_COLLECTION,
        data: userModel.toMap(),
        docId: docId,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<AdminUser?> adminLogin(String username, String password) async {
    print("Username: $username");
    print("Password: $password");
    try {
      final result = await _firestore
          .collection(AppCollections.ADMIN)
          .where("username", isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();
      print("Result: $result");
      if (result.docs.isEmpty) {
        return null;
      } else {
        final user = result.docs.first.data();
        return AdminUser.fromMap(user);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
