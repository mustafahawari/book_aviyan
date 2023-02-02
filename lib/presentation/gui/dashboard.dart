import 'package:book_aviyan_final/presentation/common_widgets/custom_bottom_navbar.dart';
import 'package:book_aviyan_final/presentation/gui/book_seller/book_seller_page.dart';
import 'package:book_aviyan_final/presentation/gui/category/category_page.dart';
import 'package:book_aviyan_final/presentation/gui/home/home.dart';
import 'package:book_aviyan_final/presentation/gui/settings/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feature/dashboard/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(LoadDashboard());

    super.initState();
  }

  int _selectedPage = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List _pages = [
    Home(),
    CategoryPage(),
    BookSellerPage(),
    SettingsPage(),
  ];

  List<String> pageTitle = ["EXPLORE", "Categories", "", "Settings"];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            pageTitle[_selectedPage],
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Icons.dashboard,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              color: Theme.of(context).colorScheme.onPrimary,
              icon: Icon(Icons.favorite),
            )
          ],
        ),
        drawer: Drawer(),
        body: _pages[_selectedPage],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedPage,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          destinations: [
            NavigationDestination(
                icon: Icon(CupertinoIcons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.tv_music_note_fill,
                ),
                label: "Category"),
            NavigationDestination(
                icon: Icon(CupertinoIcons.book_circle), label: "Sell Book"),
            NavigationDestination(
                icon: Icon(CupertinoIcons.settings), label: "Settings")
          ],
        ),
      ),
    );
  }
}
