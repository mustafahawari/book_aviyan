import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/gui/common_widgets/grid_book_widget.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/gui/pages/all_books_page.dart';
import 'package:book_aviyan_final/gui/feature/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBooks extends StatelessWidget {
  const HomeBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);
    _bookProvider.fetchProducts();
    List<BookModel> _bookList = _bookProvider.books;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "For You",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                elevation: MaterialStateProperty.all(0)
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllBooks()));
              },
              child: Text(
                "See more",
                style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => AllBooks()));
            //   },
            //   child: Text(
            //     "See more →",
            //     style: TextStyle(
            //       fontSize: 15,
            //       // fontWeight: FontWeight.bold,
            //       color: Colors.blue,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          // height: 300,
          child: FutureBuilder(
              future: _bookProvider.fetchProducts(),
              builder: (context, snapshot) {
                // if (!snapshot.hasData) {
                //   Center(child: CircularProgressIndicator());
                // }
                return GridBooks(itemCount: 6);
              }),
        )
      ],
    );
  }
}
