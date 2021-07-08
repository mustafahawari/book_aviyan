import 'package:book_aviyan_final/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final Function(int)? onChange;

  const BottomNavbar({Key? key, this.onChange}) : super(key: key);
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int? selectedItem = 2;

  InkWell buildNavBarItems(
      {IconData? icon, String? title, int? index, bool isCenterOne = false}) {
    return InkWell(
      onTap: () {
        widget.onChange!(index!);
        setState(() {
          selectedItem = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: isCenterOne ? 45 : 35,
            width: isCenterOne ? 45 : 35,
            decoration: BoxDecoration(
              color: index == selectedItem ? Colors.white : null,
              borderRadius: isCenterOne ? null : BorderRadius.circular(10),
              shape: isCenterOne ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: Icon(
              icon,
              color: index == selectedItem ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: index == selectedItem ? 12 : 10,
              color: index == selectedItem ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 70,
      decoration: BoxDecoration(
        color: AppColor.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavBarItems(
            icon: CupertinoIcons.book_circle,
            title: "Add Book",
            index: 0,
          ),
          buildNavBarItems(
            icon: CupertinoIcons.tv_music_note_fill,
            title: "Category",
            index: 1,
          ),
          buildNavBarItems(
              icon: CupertinoIcons.home,
              title: "Home",
              index: 2,
              isCenterOne: true),
          buildNavBarItems(
            icon: CupertinoIcons.music_albums,
            title: "Promotion",
            index: 3,
          ),
          buildNavBarItems(
            icon: CupertinoIcons.person,
            title: "Profile",
            index: 4,
          ),
        ],
      ),
    );
  }
}
