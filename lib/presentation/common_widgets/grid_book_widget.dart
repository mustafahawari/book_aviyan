import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/gui/book_detail_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/book_model.dart';

class GridBooks extends StatelessWidget {
  final int itemCount;
  GridBooks({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 100 / 150, // (width / height)
            ),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  // await checkAuthState().then((value) {
                  //   Provider.of<AuthProvider>(context, listen: false)
                  //       .userController
                  //       .add(UserDetail(value));
                  // });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(bookDetail: BookModel(),)
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.mainColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 110,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/cover.jpg"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Text(
                        "Book Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        
  }
}
