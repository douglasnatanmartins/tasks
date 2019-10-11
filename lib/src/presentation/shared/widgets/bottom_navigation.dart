import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final String current;
  final BuildContext context;
  final Function backDefault;
  final Map<String, Map<String, dynamic>> routes = const {
    '/settings': {
      'title': 'Setttings',
      'icon': Icons.settings,
    },
    '/important': {
      'title': 'Planned',
      'icon': Icons.star,
    },
    '/': {
      'title': 'Planned',
      'icon': Icons.calendar_today,
    },
    '/categories': {
      'title': 'Planned',
      'icon': Icons.style,
    },
  };

  BottomNavigation({
    Key key,
    @required this.context,
    @required this.current,
    this.backDefault
  }): assert(context != null),
      assert(current != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [];
    int selected = 0;

    for (var i = 0; i < this.routes.length; i++) {
      final String key = this.routes.keys.elementAt(i);
      if (this.current == key) {
        selected = i;
      }

      items.add(BottomNavigationBarItem(
        title: Text(this.routes[key]['title']),
        icon: Icon(this.routes[key]['icon'])
      ));
    }

    return Hero(
      tag: 'shared-bottom-navigation-bar',
      child: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        type: BottomNavigationBarType.fixed,
        currentIndex: selected,
        selectedFontSize: 14.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 13.0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: items,
        onTap: this.onTapped
      )
    );
  }

  void onTapped(int index) {
    final String selected = this.routes.keys.elementAt(index);

    if (this.current != selected) {
      if (this.current == '/') {
        Navigator.of(this.context).pushNamed(selected)
          .then((result) => this.backDefault());
      } else {
        if (selected == '/') {
          Navigator.of(this.context).pop();
        } else {
          Navigator.of(this.context).pushReplacementNamed(selected)
            .then((result) => this.backDefault());
        }
      }
    }
  }
}
