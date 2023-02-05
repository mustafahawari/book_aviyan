import 'package:book_aviyan_final/presentation/gui/auth/login_page.dart';
import 'package:book_aviyan_final/presentation/gui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../feature/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RootNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 100,
            ),
            Text("The Book Swap")
          ],
        ),
      ),
    );
  }
}

class RootNavigation extends StatelessWidget {
  const RootNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? LoginPage()
        : StreamBuilder(
            stream: Provider.of<AuthProvider>(context).userController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as UserDetail;
                if (data.user != null) {
                  print("Here");
                  return Dashboard();
                } else {
                  return LoginPage();
                }
              }
              return LoginPage();
            });
  }
}
