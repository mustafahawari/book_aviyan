import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/gui/common_widgets/common_textfield.dart';
import 'package:flutter/material.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({Key? key}) : super(key: key);
  @override
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
            CommonTextField(hintText: "Enter your name"),
            CommonTextField(hintText: "Enter Phone Number"),
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

  
}
