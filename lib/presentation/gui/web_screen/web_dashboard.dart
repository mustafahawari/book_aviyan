import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/presentation/feature/category/category_bloc.dart';
import 'package:book_aviyan_final/presentation/gui/web_screen/category/category_page.dart';
import 'package:book_aviyan_final/presentation/gui/web_screen/category/sub_category.dart';
import 'package:flutter/material.dart';

class WebDashboard extends StatefulWidget {
  @override
  State<WebDashboard> createState() => _WebDashboardState();
}

class _WebDashboardState extends State<WebDashboard> {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;
  late bool showNavigationDrawer;

  final CategoryBloc categoryBloc = CategoryBloc(getIt());
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(WebCategoryPage(categoryBloc: categoryBloc));
    _pages.add(WebSubCategoryPage(categoryBloc: categoryBloc));
    categoryBloc.add(GetAllCategory());
    
  }

  @override
  void dispose() {
    categoryBloc.close();
    super.dispose();
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      // floatingActionButton: screenIndex == 0
      //     ? FloatingActionButton(
      //         onPressed: () {},
      //         child: Icon(Icons.add),
      //       )
      //     : null,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: NavigationDrawer(
                onDestinationSelected: handleScreenChanged,
                selectedIndex: screenIndex,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                    child: Text(
                      'The Book Swap',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ...destinations.map((ExampleDestination destination) {
                    return NavigationDrawerDestination(
                      label: Text(destination.label),
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            Expanded(child: _pages[screenIndex]),
          ],
        ),
      ),
      // endDrawer:
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawerScaffold(context);
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'Category Controller', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  ExampleDestination('Sub Category Controller',
      Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
];
