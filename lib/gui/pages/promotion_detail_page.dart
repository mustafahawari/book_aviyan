import 'package:flutter/material.dart';

class PromotionDetail extends StatelessWidget {
  final int index;
  PromotionDetail({Key? key, required this.index}) : super(key: key);

  final List<String> _images = [
    "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/41XgvthG9TL._SX331_BO1,204,203,200_.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1594616847",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Color(0xff7ACED2),
            height: 200,
            width: double.infinity,
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 350,
                alignment: Alignment.center,
                child: Image.network(
                  _images[index],
                  width: 150,
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price\nRs:- 155",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff7ACED2))),
                      child: Text("Buy"),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          )
          // Column(
          //   children: [
          //     SizedBox(height: 180),
          //     Expanded(
          //       child: DecoratedBox(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
