import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/feature/category/category_bloc.dart';
import 'package:book_aviyan_final/presentation/gui/category/category_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/loader_widget.dart';
import '../../../data/models/category/main_category_model.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _categoryProvider = Provider.of<CategoryProvider>(context);
    // List _categoryList = _categoryProvider.categories;
    // final userProvider = Provider.of<UserProvider>(context);
    // userProvider.userData();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream:
                      BlocProvider.of<CategoryBloc>(context).categories.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CenterCircularLoader();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data as List<MainCategoryModel>;
                      if (data.isEmpty) {
                        return Center(child: Text("No data"));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => CategoryBook(
                                //       categoryName: _categoryList[index].name,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    // borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(3, 6),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        blurRadius: 7,
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    data[index].name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Text("err");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
