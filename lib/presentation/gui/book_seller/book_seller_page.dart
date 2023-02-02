import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/presentation/gui/upload_books/upload_books_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookSellerPage extends StatelessWidget {
  const BookSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/book_promote.png",
                  height: 300,
                  width: double.infinity,
                ),
                // Text(
                //   "Promote",
                //   style: TextStyle(
                //     color: Colors.teal,
                //     fontSize: 30,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Text(
                  "You haven't listed or sold any books yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(
                      //     Colors.teal.withOpacity(0.5)),
                      // foregroundColor: MaterialStateProperty.all(Colors.white)),
                  ),
                  onPressed: () {
                    if (getIt<FirebaseAuth>().currentUser == null) {
                      ToastUtils.showToast(
                          "Please login to continue", ToastType.ERROR);
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadBooksPage(),
                        ),
                      );
                  },
                  child: Text("Sell your book"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
