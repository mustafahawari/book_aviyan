import 'package:book_aviyan_final/models/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List _books = [
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 1",
        category: "Business",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 2",
        category: "IT",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 3",
        category: "Maths",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 4",
        category: "Bachelor",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 5",
        category: "Science",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 1",
        category: "Business",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 2",
        category: "IT",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 3",
        category: "Maths",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 4",
        category: "Bachelor",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
    BookModel(
        coverImage:
            "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
        title: "Book Title 5",
        category: "Science",
        description:
            "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada."),
  ];

  List<BookModel> get books => [..._books];

  List<BookModel> filterByCategory(String categoryName) {
    List _categoryList = _books
        .where((element) =>
            element.category.toLowerCase().contains(categoryName.toLowerCase()))
        .toList();
    return [..._categoryList];
  }
}
