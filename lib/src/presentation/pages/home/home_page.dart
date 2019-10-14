import 'package:flutter/material.dart';

import 'package:tasks/src/presentation/pages/categories/categories_page.dart';
import 'package:tasks/src/presentation/pages/important/important_page.dart';
import 'package:tasks/src/presentation/pages/planned/planned_page.dart';
import 'package:tasks/src/presentation/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = <Widget>[
    SettingsPage(),
    ImportantPage(),
    PlannedPage(),
    CategoriesPage()
  ];

  int current;

  @override
  void initState() {
    super.initState();
    this.current = 2;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapped(int index) {
    setState(() {
      this.current = index;
    });
  }

  Future<bool> willPop() async {
    if (this.current != 2) {
      this.onTapped(2);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.willPop,
      child: Scaffold(
        body: this.pages.elementAt(this.current),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          type: BottomNavigationBarType.fixed,
          currentIndex: this.current,
          selectedFontSize: 14.0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 13.0,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings)
            ),
            BottomNavigationBarItem(
              title: Text('Important'),
              icon: Icon(Icons.star)
            ),
            BottomNavigationBarItem(
              title: Text('Planned'),
              icon: Icon(Icons.calendar_today)
            ),
            BottomNavigationBarItem(
              title: Text('Category'),
              icon: Icon(Icons.style)
            )
          ],
          onTap: this.onTapped
        )
      ),
    );
  }
}
