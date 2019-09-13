import 'package:flutter/material.dart';

import 'package:tasks/src/presentation/pages/board/board_page.dart';
import 'package:tasks/src/presentation/pages/categories/categories_page.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  final pages = [
    BoardPage(),
    CategoriesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Colors.indigo,
            border: Border.all(
              color: Colors.indigo,
              width: 0.0
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Hello Steve',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        )
                      ),
                      Text(
                        'You have 8 tasks in today',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8)
                        )
                      )
                    ],
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.settings),
                    onPressed: () {}
                  )
                ]
              )
            ]
          )
        )
      ),
      body: pages[selected],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        selectedItemColor: UIColors.BlueDark,
        selectedLabelStyle: TextStyle(color: UIColors.BlueDark),
        unselectedFontSize: 12.0,
        currentIndex: selected,
        onTap: (int selected) {
          setState(() {
            this.selected = selected;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            title: Text('Categories')
          )
        ]
      ),
    );
  }
}
