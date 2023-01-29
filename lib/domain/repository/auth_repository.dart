import 'package:book_aviyan_final/data/data_sources/auth_remote_data_source.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';

abstract class AuthRepository {
  Future<void> signIn(UserModel userModel, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<void> signIn(UserModel userModel, String password) async {
    try {
      await authRemoteDataSource.signUp(userModel, password);
    } catch (e) {
      throw e;
    }
  }
}
