import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/pages/categories/categories_page.dart';
import 'package:tasks/src/presentation/pages/important/important_page.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int current;
  final BuildContext context;

  final _pages = <Widget>[
    ImportantPage(),
    CategoriesPage()
  ];

  BottomNavigation({@required this.context, @required this.current});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: current,
      selectedFontSize: 14.0,
      selectedItemColor: UIColors.Blue,
      selectedLabelStyle: TextStyle(color: UIColors.Blue),
      unselectedFontSize: 12.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text('Important')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.style),
          title: Text('Categories')
        )
      ],
      onTap: onTabTapped
    );
  }

  void onTabTapped(int index) {
    if (this.current != index) {
      Navigator.of(this.context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return _pages[index];
          }
        )
      );
    }
  }
}
