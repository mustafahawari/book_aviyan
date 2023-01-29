import 'dart:developer';

import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List _books = [];
  Future fetchProducts() async {
    await FirebaseFirestore.instance
        .collection("books")
        .get()
        .then((value) => print(value))
        .onError((error, stackTrace) => print(error));
    // log("Result: $result");
    //     .then((QuerySnapshot booksSnapshot) {
    //   _books = [];
    //   booksSnapshot.docs.forEach((element) {
    //     _books.insert(
    //       0,
    //       BookModel(
    //         id: element.get("bookId"),
    //         title: element.get("bookName"),
    //         description: element.get("description"),
    //         category: element.get("category"),
    //         coverImage: element.get("bookImage"),
    //         phoneNumber: int.parse(element.get("phoneNumber")),
    //         location: element.get("location"),
    //       ),
    //     );
    //   });
    // });
    // return [_books];
  }

  List<BookModel> get books => [..._books];

  List<BookModel> filterByCategory(String categoryName) {
    List _categoryList = _books
        .where((element) =>
            element.category.toLowerCase().contains(categoryName.toLowerCase()))
        .toList();
    return [..._categoryList];
  }
}
