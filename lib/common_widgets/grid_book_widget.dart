import 'package:book_aviyan_final/consts/colors.dart';
import 'package:book_aviyan_final/models/book_model.dart';
import 'package:book_aviyan_final/pages/book_description_page.dart';
import 'package:book_aviyan_final/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridBooks extends StatelessWidget {
  final int itemCount;
  GridBooks({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);
    List<BookModel> _bookList = _bookProvider.books;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 100 / 150, // (width / height)
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetails()),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.mainColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 110,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_bookList[index].coverImage!),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Text(
                  _bookList[index].title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
