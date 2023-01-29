import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:book_aviyan_final/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.initial;
  String? errorMessage;
  AuthRepository authRepository;
  AuthProvider(this.authRepository);

  Future<void> signInWithEmailAndPassword(
      UserModel userModel, String password) async {
    try {
      status = AuthStatus.loading;
      notifyListeners();
      await authRepository.signIn(userModel, password);
      status = AuthStatus.success;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      status = AuthStatus.error;
      errorMessage = error.message;
      notifyListeners();
    } catch (e) {
      status = AuthStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}
