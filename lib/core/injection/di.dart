import 'package:book_aviyan_final/core/injection/di.config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init')
void configureDependencies() => getIt.init();

@module  
abstract class RegisterModule {  
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}  


//flutter pub run build_runner build --delete-conflicting-outputs
