import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const CommonTextField({Key? key, required this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
          hintText: hintText,
          // filled: true,
          // fillColor: AppColor.mainColor,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
