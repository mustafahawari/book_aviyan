// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_aviyan_final/core/injection/di.dart' as _i13;
import 'package:book_aviyan_final/core/network/firebase_service.dart' as _i5;
import 'package:book_aviyan_final/data/data_sources/auth/auth_remote_data_source.dart'
    as _i7;
import 'package:book_aviyan_final/data/data_sources/books/books_remote_data_sources.dart'
    as _i9;
import 'package:book_aviyan_final/data/data_sources/category/category_remote_data_source.dart'
    as _i11;
import 'package:book_aviyan_final/domain/repository/auth_repository.dart'
    as _i8;
import 'package:book_aviyan_final/domain/repository/books_repository.dart'
    as _i10;
import 'package:book_aviyan_final/domain/repository/category_repository.dart'
    as _i12;
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i4.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.lazySingleton<_i5.FirebaseService>(
        () => _i5.FirebaseService(gh<_i4.FirebaseFirestore>()));
    gh.lazySingleton<_i6.FirebaseStorage>(() => registerModule.firebaseStorage);
    gh.lazySingleton<_i7.AuthRemoteDataSource>(
        () => _i7.AuthRemoteDataSourceImpl(
              gh<_i5.FirebaseService>(),
              gh<_i3.FirebaseAuth>(),
              gh<_i4.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i8.AuthRepository>(
        () => _i8.AuthRepositoryImpl(gh<_i7.AuthRemoteDataSource>()));
    gh.lazySingleton<_i9.BooksRemoteDataSource>(
        () => _i9.BooksRemoteDataSourceImpl(
              gh<_i5.FirebaseService>(),
              gh<_i6.FirebaseStorage>(),
              gh<_i4.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i10.BooksRepository>(
        () => _i10.BooksRepositoryImpl(gh<_i9.BooksRemoteDataSource>()));
    gh.lazySingleton<_i11.CategoryRemoteDataSource>(
        () => _i11.CategoryRemoteDataSourceImpl(
              gh<_i5.FirebaseService>(),
              gh<_i4.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i12.CategoryRepository>(
        () => _i12.CategoryRepositoryImpl(gh<_i11.CategoryRemoteDataSource>()));
    return this;
  }
}

class _$RegisterModule extends _i13.RegisterModule {}
