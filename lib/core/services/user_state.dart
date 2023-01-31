import 'dart:developer';

import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/gui/feature/auth_provider.dart';
import 'package:book_aviyan_final/gui/pages/auth/login_page.dart';
import 'package:book_aviyan_final/gui/pages/book_description_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends StatefulWidget {
  final int index;
  const UserState({Key? key, required this.index}) : super(key: key);

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  bool isTokenCheckCompleted = false;

  @override
  void initState() {
    super.initState();
    // checkLogin();
    // getIt<FirebaseAuth>().authStateChanges().listen((event) {
    //   Provider.of<AuthProvider>(context, listen: false)
    //       .userController
    //       .add(event);
    // });
  }

  // checkLogin() async {
  //   await checkAuthState().then(
  //     (value) async {
  //       setState(() {
  //         isTokenCheckCompleted = true;
  //       });
  //       log(isTokenCheckCompleted.toString());
  //       Provider.of<AuthProvider>(context, listen: false)
  //           .userController
  //           .add(value);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthProvider>(context).userController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          log("waiting");
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          log("hasdata");
          log("snap: ${snapshot.data}");
          final data = snapshot.data as UserDetail;
          log("snap: ${data.user}");
          if (data.user != null) {
            log("User ${snapshot.data}");
            return BookDetails();
          } else {
            return LoginPage();
          }
        } else if (snapshot.hasError) {
          log("has error");
          Center(child: Text(snapshot.error.toString()));
        } else {
          log(snapshot.toString());
          log("else");
          return LoginPage();
        }

        return Center(child: Text("Could not Find"));
      },
    );
  }
}
