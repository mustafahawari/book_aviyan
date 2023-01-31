import 'package:book_aviyan_final/data/data_sources/auth_remote_data_source.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<User?> signUp(UserModel userModel, String password);
  Future<User?> signIn(String email, String password);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<User?> signUp(UserModel userModel, String password) async {
    try {
      final result = await authRemoteDataSource.signUp(userModel, password);
      return result;
    } catch (e) {
      throw e;

    }
  }

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await authRemoteDataSource.signIn(email, password);
      return result;
    } catch (e) {
      throw e;
    }
  }
}
