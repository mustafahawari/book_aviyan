import 'package:book_aviyan_final/common_widgets/grid_book_widget.dart';
import 'package:book_aviyan_final/consts/colors.dart';
import 'package:book_aviyan_final/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryBook extends StatelessWidget {
  final String categoryName;
  const CategoryBook({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);
    List _booksByCategory = _bookProvider.filterByCategory(categoryName);
    // print(categoryName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text(categoryName),
      ),
      body: GridBooks(
        itemCount: _booksByCategory.length,
      ),
    );
  }
}
