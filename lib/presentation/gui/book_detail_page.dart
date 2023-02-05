import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/book_model.dart';

class BookDetailPage extends StatelessWidget {
  final BookModel bookDetail;
  BookDetailPage({required this.bookDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: Text(
          "Book Details",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(3),
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          // color: AppColor.mainColor,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Buy Now',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CachedNetworkImage(
                      imageUrl: bookDetail.coverImage!,
                      fit: BoxFit.contain,
                      height: 350,
                      width: double.infinity,
                      progressIndicatorBuilder: (context, url, progress) {
                        return CircularProgressIndicator(
                          value: progress.progress,
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // _bookAttributes.title!,
                        bookDetail.title ?? "",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Book Author:   ",
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(bookDetail.author ?? "",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Printed Price",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Rs " +
                                      bookDetail.printedPrice!
                                          .toInt()
                                          .toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                            ],
                          ),
                          // RichText(
                          //   text: TextSpan(
                          //     text: "Printed Price: ",
                          //     style: Theme.of(context).textTheme.bodyMedium,
                          //     children: [
                          //       TextSpan(
                          //         text: "Rs.1500",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .titleMedium!
                          //             .copyWith(
                          //                 decoration:
                          //                     TextDecoration.lineThrough),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Column(
                            children: [
                              Text("Selling Price",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!),
                              ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onPrimary),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                ),
                                onPressed: () {},
                                child: Text("Rs " +
                                    bookDetail.sellingPrice!
                                        .toInt()
                                        .toString()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Description",
                  style: Theme.of(context).textTheme.titleMedium),
              Text(
                  // _bookAttributes.description!,
                  bookDetail.description ?? "N/A",
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 20),

              Text("More Info",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _moreBookInfo(
                        context,
                        "Publisher",
                        bookDetail.publisher ?? "N/A",
                      ),
                      _moreBookInfo(
                        context,
                        "Edition",
                        bookDetail.edition ?? "N/A",
                      ),
                      _moreBookInfo(
                        context,
                        "Category",
                        bookDetail.category ?? "N/A",
                      ),
                      _moreBookInfo(
                        context,
                        "Sub-Category",
                        bookDetail.subCategory ?? "N/A",
                      ),
                      _moreBookInfo(
                        context,
                        "Location",
                        bookDetail.location ?? "N/A",
                      ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   // _bookAttributes.location!,
              //   "location",
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
              // SizedBox(height: 20),
              // Text(
              //   "Contact Details",
              //   style: TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Text(
              //   // _bookAttributes.phoneNumber!.toString(),
              //   "phone number",
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Row _moreBookInfo(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          // color: Theme.of(context).colorScheme.,
          height: 40,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          height: 40,
          child: VerticalDivider(),
        ),
        Container(
          alignment: Alignment.center,
          // color: Theme.of(context).colorScheme.,
          height: 40,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
