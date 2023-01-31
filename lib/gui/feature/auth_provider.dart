import 'dart:async';
import 'dart:developer';

import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:book_aviyan_final/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../core/injection/di.dart';

class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.initial;
  String? errorMessage;
  AuthRepository authRepository;
  BehaviorSubject<UserDetail?> userController = BehaviorSubject<UserDetail?>();
  AuthProvider(this.authRepository) {
    getIt<FirebaseAuth>().userChanges().listen((event) async {
      print("called userChanges");
      final result = UserDetail(event);
      userController.add(result);
    });
  }

  Future<User?> signUpWithEmailAndPassword(
      UserModel userModel, String password) async {
    try {
      status = AuthStatus.loading;
      notifyListeners();
      final result = await authRepository.signUp(userModel, password);
      status = AuthStatus.success;
      notifyListeners();
      return result;
    } catch (e) {
      status = AuthStatus.error;
      errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      status = AuthStatus.loading;
      notifyListeners();
      await authRepository.signIn(email, password);
      status = AuthStatus.success;
      notifyListeners();
    } catch (e) {
      status = AuthStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      status = AuthStatus.loading;
      notifyListeners();
      await getIt<FirebaseAuth>().signOut();
      status = AuthStatus.success;
      notifyListeners();
    } catch (e) {
      status = AuthStatus.error;
      notifyListeners();
      print(e);
    }
  }
}

Future<User?> checkAuthState() async {
  final auth = FirebaseAuth.instance;
  try {
    await auth.currentUser?.reload();
    log(auth.currentUser.toString());
    return auth.currentUser;
  } catch (e) {
    log(e.toString());
    return auth.currentUser;
  }
}

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class UserDetail {
  final User? user;
  UserDetail(this.user);
}
