import 'package:book_aviyan_final/gui/common_widgets/search_bar.dart';
import 'package:book_aviyan_final/gui/pages/home/home_widgets/home_book.dart';
import 'package:book_aviyan_final/gui/pages/home/home_widgets/home_category.dart';
import 'package:book_aviyan_final/gui/pages/home/home_widgets/promotion_carousel.dart';
import 'package:book_aviyan_final/gui/feature/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // userProvider.userData();
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.dashboard),
                  Consumer<UserProvider>(builder: (context, userProvider, _) {
                    return userProvider.isAuthenticated
                        ? Image.network(userProvider.imageUrl!)
                        : Icon(Icons.shopping_cart_checkout);
                  }),
                ],
              ),
              Text(
                "Explore".toUpperCase(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SearchBar(),
              SizedBox(height: 20),
              PromotionCarousel(),
              SizedBox(height: 20),
              HomeCategory(),
              SizedBox(height: 20),
              HomeBooks()
            ],
          ),
        ),
      ),
    );
  }
}
