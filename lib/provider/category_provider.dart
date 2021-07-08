import 'package:book_aviyan_final/models/book_model.dart';
import 'package:book_aviyan_final/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  BookModel books = BookModel();
  List _categories = [
    CategoryModel(name: "Primary level"),
    CategoryModel(name: "Secondary level"),
    CategoryModel(name: "Bachelor"),
    CategoryModel(name: "Science"),
    CategoryModel(name: "SlC"),
    CategoryModel(name: "Class 9"),
    CategoryModel(name: "Mathematics"),
    CategoryModel(name: "business"),
  ];

  List<CategoryModel> get categories => [..._categories];
}
