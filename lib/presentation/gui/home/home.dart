import 'package:book_aviyan_final/core/utils/loader_widget.dart';
import 'package:book_aviyan_final/presentation/common_widgets/search_bar.dart';
import 'package:book_aviyan_final/presentation/feature/dashboard/dashboard_bloc.dart';
import 'package:book_aviyan_final/presentation/gui/home/home_widgets/home_book.dart';
import 'package:book_aviyan_final/presentation/gui/home/home_widgets/home_category.dart';
import 'package:book_aviyan_final/presentation/gui/home/home_widgets/promotion_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/book_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: BlocProvider.of<DashboardBloc>(context).allBooks.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CenterCircularLoader();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final books = snapshot.data as List<BookModel>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SearchBar(),
                    SizedBox(height: 20),
                    PromotionCarousel(),
                    SizedBox(height: 20),
                    HomeCategory(),
                    SizedBox(height: 20),
                    books.isEmpty
                        ? Center(
                            child: Text("No books to show"),
                          )
                        : HomeBooks(forYouBooks: books)
                  ],
                ),
              ),
            );
          }
          return CenterCircularLoader();
        },
      ),
    );
  }
}
