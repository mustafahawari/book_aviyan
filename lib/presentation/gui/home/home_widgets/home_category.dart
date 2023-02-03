import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/gui/category/category_books.dart';
import 'package:book_aviyan_final/presentation/feature/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    List _booksByCategory = _categoryProvider.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Browse By Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemCount: _booksByCategory.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryBook(
                          categoryName: _booksByCategory[index].name),
                    ),
                  );
                  // print("${_booksByCategory[index].name}");
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  clipBehavior: Clip.hardEdge,
                  child: Text(
                    _booksByCategory[index].name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
