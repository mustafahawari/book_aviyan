import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/gui/all_books_page.dart';
import 'package:book_aviyan_final/presentation/gui/book_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/book_model.dart';

class HomeBooks extends StatelessWidget {
  final List<BookModel> forYouBooks;
  const HomeBooks({Key? key, required this.forYouBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "For You",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllBooks()));
              },
              child: Text(
                "See more",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (size.width / 3) / 240,
          ),
          shrinkWrap: true,
          itemCount: forYouBooks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookDetailPage(bookDetail: forYouBooks[index])),
                );
              },
              child: Card(
                elevation: 5,
                shadowColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              forYouBooks[index].coverImage!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forYouBooks[index].title ?? "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs." +
                                      forYouBooks[index]
                                          .sellingPrice!
                                          .toInt()
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs." +
                                      forYouBooks[index]
                                          .printedPrice!
                                          .toInt()
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
