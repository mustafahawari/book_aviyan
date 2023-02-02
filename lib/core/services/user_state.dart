// import 'dart:developer';

// import 'package:book_aviyan_final/core/injection/di.dart';
// import 'package:book_aviyan_final/presentation/feature/auth_provider.dart';
// import 'package:book_aviyan_final/presentation/gui/auth/login_page.dart';
// import 'package:book_aviyan_final/presentation/gui/book_description_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class UserState extends StatefulWidget {
//   final int index;
//   const UserState({Key? key, required this.index}) : super(key: key);

//   @override
//   State<UserState> createState() => _UserStateState();
// }

// class _UserStateState extends State<UserState> {
//   bool isTokenCheckCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Provider.of<AuthProvider>(context).userController.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           log("waiting");
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasData) {
//           log("hasdata");
//           log("snap: ${snapshot.data}");
//           final data = snapshot.data as UserDetail;
//           log("snap: ${data.user}");
//           if (data.user != null) {
//             log("User ${snapshot.data}");
//             return BookDetailPage();
//           } else {
//             return LoginPage();
//           }
//         } else if (snapshot.hasError) {
//           log("has error");
//           Center(child: Text(snapshot.error.toString()));
//         } else {
//           log(snapshot.toString());
//           log("else");
//           return LoginPage();
//         }

//         return Center(child: Text("Could not Find"));
//       },
//     );
//   }
// }
