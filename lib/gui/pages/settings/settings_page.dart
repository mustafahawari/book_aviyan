import 'package:book_aviyan_final/gui/pages/profile/user_profile_page.dart';
import 'package:book_aviyan_final/gui/pages/promotion/promotion_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Settings", ),
      ),
      
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
            },
            leading: Icon(CupertinoIcons.person,),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionPage()));
            },
            leading: Icon(Icons.help,),
            title: Text("Promote your books"),
          ),
        ],
      ),
    );
  }
}
