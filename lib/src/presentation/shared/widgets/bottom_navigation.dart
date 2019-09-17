import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int selected;
  final BuildContext context;

  BottomNavigation({@required this.context, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return
    BottomNavigationBar(
      currentIndex: selected,
      selectedFontSize: 14.0,
      selectedItemColor: UIColors.Blue,
      selectedLabelStyle: TextStyle(color: UIColors.Blue),
      unselectedFontSize: 12.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.style),
          title: Text('Categories')
        )
      ],
      onTap: (int index) {
      }
    );
  }

  void onTabTapped(int index) {
  }
}
