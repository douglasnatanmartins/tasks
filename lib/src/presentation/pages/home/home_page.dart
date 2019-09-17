import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/board/board_page.dart';
import 'package:tasks/src/presentation/pages/categories/categories_page.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/new_category_form.dart';
import 'package:tasks/src/presentation/ui_colors.dart';
import 'package:tasks/src/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  final pages = <Widget>[
    BoardPage(),
    CategoriesPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: UIColors.Blue,
            border: Border.all(
              color: UIColors.Blue,
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
                        'Tenla: Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        )
                      ),
                      StreamBuilder(
                        stream: Provider.of<HomePageBloc>(context).streamAnnouncement,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85)
                              )
                            );
                          }
                          return Text('');
                        }
                      )
                    ]
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
      body: this.pages[this.selected],
      bottomNavigationBar: buildBottomNavigation(),
      floatingActionButton: buildFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBar buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: this.selected,
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
        setState(() {
          this.selected = index;
        });
      }
    );
  }

  FloatingActionButton buildFloatButton() {
    if (this.pages[this.selected] is CategoriesPage) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) {
              return NewCategoryForm();
            }
          );

          if (result is CategoryModel) {
            Provider.of<HomePageBloc>(context).addCategory(result);
          }
        }
      );
    }
    return null;
  }
}
