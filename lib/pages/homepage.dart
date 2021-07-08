import 'package:book_aviyan_final/common_widgets/custom_bottom_navbar.dart';
import 'package:book_aviyan_final/pages/category/category_page.dart';
import 'package:book_aviyan_final/pages/home/home.dart';
import 'package:book_aviyan_final/pages/profile/user_profile_page.dart';
import 'package:book_aviyan_final/pages/promotion/promotion_page.dart';
import 'package:book_aviyan_final/pages/upload_books/upload_books_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 2;
  List _pages = [
    UploadBooksPage(),
    CategoryPage(),
    Home(),
    PromotionPage(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavbar(
        onChange: (index) {
          _selectedPage = index;
          setState(() {});
        },
      ),
    );
  }
}
