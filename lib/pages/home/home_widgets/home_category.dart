import 'package:book_aviyan_final/consts/colors.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  final List bookCategory = [
    "Maths",
    "Science",
    "Computer",
    "Social",
    "Primary",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Browse By Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemCount: 6,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.blue.shade100,
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.mainColor,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Text(bookCategory[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
