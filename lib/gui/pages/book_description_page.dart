import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _bookAttributes = Provider.of<BookModel>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          // _bookAttributes.title!,
          "title",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
                      height: size.height * 0.5,
                      width: double.infinity,
                      color: AppColor.mainColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Image.asset(
                      // _bookAttributes.coverImage!,
                      "assets/images/cover.jpg",
                      fit: BoxFit.fill,
                      height: size.height * 0.6,
                      width: double.infinity,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text(
                // _bookAttributes.title!,
                "title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.mainColor)),
                    onPressed: () {},
                    child: Text("Request"),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // _bookAttributes.description!,
                "description",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // _bookAttributes.location!,
                "location",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Contact Details",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // _bookAttributes.phoneNumber!.toString(),
                "phone number",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
