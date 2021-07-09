import 'package:book_aviyan_final/common_widgets/grid_book_widget.dart';
import 'package:book_aviyan_final/pages/all_books_page.dart';
import 'package:flutter/material.dart';

class HomeBooks extends StatelessWidget {
  const HomeBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: GridBooks(itemCount: 6),
        )
      ],
    );
  }
}
