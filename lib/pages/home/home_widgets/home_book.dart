import 'package:book_aviyan_final/common_widgets/grid_book_widget.dart';
import 'package:book_aviyan_final/models/book_model.dart';
import 'package:book_aviyan_final/pages/all_books_page.dart';
import 'package:book_aviyan_final/provider/book_provider.dart';
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
              "All Books",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllBooks()));
              },
              child: Text(
                "See all books →",
                style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: FutureBuilder(
              future: _bookProvider.fetchProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  Center(child: CircularProgressIndicator());
                }
                return GridBooks(itemCount: 6);
              }),
        )
      ],
    );
  }
}
