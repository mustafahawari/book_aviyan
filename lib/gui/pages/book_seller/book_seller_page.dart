import 'package:book_aviyan_final/gui/pages/upload_books/upload_books_page.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/common_textfield.dart';

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
                    backgroundColor:
                        MaterialStateProperty.all(Colors.teal.withOpacity(0.5)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UploadBooksPage()));
                  },
                  child: Text("Sell your book"),
                ),
                // Text(
                //   "Please fill up the form we will contact you shortly!",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
