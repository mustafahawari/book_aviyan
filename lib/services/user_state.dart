import 'package:book_aviyan_final/models/book_model.dart';
import 'package:book_aviyan_final/pages/auth/landing_page.dart';
import 'package:book_aviyan_final/pages/book_description_page.dart';
import 'package:book_aviyan_final/provider/book_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends StatelessWidget {
  final int index;
  const UserState({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);
    List<BookModel> _bookList = _bookProvider.books;

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider.value(
                value: _bookList[index], child: BookDetails());
          } else {
            return LandingPage();
          }
        } else if (snapshot.hasError) {
          Center(child: Text("Error Occured"));
        }

        return Center(child: Text("Could not Find"));
      },
    );
  }
}
