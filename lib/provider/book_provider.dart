import 'package:book_aviyan_final/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List _books = [];
  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection("books")
        .get()
        .then((QuerySnapshot booksSnapshot) {
      _books = [];
      booksSnapshot.docs.forEach((element) {
        _books.insert(
          0,
          BookModel(
            id: element.get("bookId"),
            title: element.get("bookName"),
            description: element.get("description"),
            category: element.get("category"),
            coverImage: element.get("bookImage"),
            phoneNumber: int.parse(element.get("phoneNumber")),
            location: element.get("location"),
          ),
        );
      });
    });
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
