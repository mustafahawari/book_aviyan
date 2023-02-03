import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:flutter/material.dart';

class CenterCircularLoader extends StatelessWidget {
  const CenterCircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        // color: AppColor.mainColor,
      ),
    );
  }
}
