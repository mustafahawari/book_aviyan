import 'package:book_aviyan_final/core/consts/app_collections.dart';
import 'package:book_aviyan_final/core/network/firebase_service.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(UserModel userModel, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseService firebaseService;

  AuthRemoteDataSourceImpl(this.firebaseService, this.auth);
  @override
  Future<void> signUp(UserModel userModel, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: userModel.email!, password: password);
      if (result.user != null)
        saveUserInfoToDb(userModel, result.user!.uid);
      else
        throw "Error adding user! Try Again!!";
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserInfoToDb(UserModel userModel, String docId) async {
    try {
      await firebaseService.update(
        AppCollections.USER_COLLECTION,
        data: userModel.toMap(),
        docId: docId,
      );
    } catch (e) {
      throw e;
    }
  }
}
