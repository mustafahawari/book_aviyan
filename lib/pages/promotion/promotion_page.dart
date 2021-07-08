import 'package:book_aviyan_final/consts/colors.dart';
import 'package:flutter/material.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/book_promote.png",
              height: 300,
              width: double.infinity,
            ),
            // Text(
            //   "Promote",
            //   style: TextStyle(
            //     color: Colors.teal,
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Text(
              "Want to promote your published books?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            userInfoForm("Enter your name"),
            userInfoForm("Enter Phone Number"),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.teal.withOpacity(0.5)),
              ),
              onPressed: () {},
              child: Text("Submit"),
            ),
            Text(
              "Please fill up the form we will contact you shortly!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Padding userInfoForm(String hintText) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            hintText: hintText,
            filled: true,
            fillColor: AppColor.mainColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
