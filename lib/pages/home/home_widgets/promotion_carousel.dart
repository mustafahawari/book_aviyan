import 'package:book_aviyan_final/consts/colors.dart';
import 'package:book_aviyan_final/pages/promotion_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class PromotionCarousel extends StatelessWidget {
  final List<String> _images = [
    "https://i.pinimg.com/236x/0c/ee/7e/0cee7e54fda8ac99ec11459448e89c7d.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/41XgvthG9TL._SX331_BO1,204,203,200_.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1594616847",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 40),
          height: 200,
          color: AppColor.mainColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Books",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 20),
              height: 150,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _images[index],
                    fit: BoxFit.fill,
                  );
                },

                autoplay: true,
                fade: 0.1,
                viewportFraction: 0.4,
                scale: 0.5,
                itemCount: _images.length,
                pagination: SwiperPagination(),
                onTap: (index) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PromotionDetail(
                            index: index,
                          )));
                },
                // control: SwiperControl(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
