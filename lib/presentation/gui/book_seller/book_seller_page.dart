import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/core/utils/loader_widget.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/presentation/gui/upload_books/upload_books_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/book/book_bloc.dart';

class BookSellerPage extends StatelessWidget {
  const BookSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              state.sellerBooks != null && state.sellerBooks!.isNotEmpty
                  ? SellerBooksWidget(sellerBooks: state.sellerBooks!)
                  : EmptySellerBooks(),
              state.status == BookStatus.initial
                  ? CenterCircularLoader()
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}

class EmptySellerBooks extends StatelessWidget {
  const EmptySellerBooks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
              Text(
                "You haven't listed or sold any books yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () {
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
    );
  }
}

class SellerBooksWidget extends StatelessWidget {
  final List<BookModel> sellerBooks;

  const SellerBooksWidget({Key? key, required this.sellerBooks})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sellerBooks.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: sellerBooks[index].coverImage!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(sellerBooks[index].title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Row(
                                  children: [
                                    Text("Selling Price: "),
                                    Text(
                                      sellerBooks[index]
                                          .sellingPrice!
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Status: "),
                                    Text(
                                      sellerBooks[index].status!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          FilledButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
              // minimumSize: MaterialStateProperty.all(Size(double.infinity, 50))
            ),
            onPressed: () {
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
    );
  }
}
