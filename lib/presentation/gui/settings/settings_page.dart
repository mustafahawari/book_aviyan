import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/presentation/gui/auth/login_page.dart';
import 'package:book_aviyan_final/presentation/gui/profile/user_profile_page.dart';
import 'package:book_aviyan_final/presentation/gui/promotion/promotion_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/injection/di.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (getIt<FirebaseAuth>().currentUser == null) {
              ToastUtils.showToast(
                  "Please login to check Profile", ToastType.ERROR);
            } else
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
          },
          leading: Icon(
            CupertinoIcons.person,
          ),
          title: Text("Profile"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PromotionPage()));
          },
          leading: Icon(
            Icons.help,
          ),
          title: Text("Promote your books"),
        ),
        getIt<FirebaseAuth>().currentUser == null
            ? ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                leading: Icon(
                  Icons.login,
                ),
                title: Text("Sign In"),
              )
            : SizedBox()
      ],
    );
  }
}
