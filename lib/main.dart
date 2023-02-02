
import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/presentation/feature/auth_provider.dart';
import 'package:book_aviyan_final/presentation/feature/book/book_bloc.dart';
import 'package:book_aviyan_final/presentation/feature/dashboard/dashboard_bloc.dart';
import 'package:book_aviyan_final/presentation/feature/book_provider.dart';
import 'package:book_aviyan_final/presentation/feature/category_provider.dart';
import 'package:book_aviyan_final/presentation/feature/user_provider.dart';
import 'package:book_aviyan_final/presentation/gui/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(getIt())),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        BlocProvider<BookBloc>(
          create: (context) => BookBloc(
            getIt(),
          ),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(
            getIt(),
          ),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Book Swap',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
            // appBarTheme: AppBarTheme(
            //   backgroundColor: Theme.of(context).colorScheme.primary
            // ),
            // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow,),
            // primarySwatch: AppColor.tealMaterial,
            // primaryColor: AppColor.mainColor,
          ),
          home: SplashPage()),
    );
  }
}
