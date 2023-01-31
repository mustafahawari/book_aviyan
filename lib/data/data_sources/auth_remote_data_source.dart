import 'package:book_aviyan_final/core/consts/app_collections.dart';
import 'package:book_aviyan_final/core/network/firebase_service.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUp(UserModel userModel, String password);
  Future<User?> signIn(String email, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseService firebaseService;

  AuthRemoteDataSourceImpl(this.firebaseService, this.auth);
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
}
