import 'package:flutter/material.dart';
import 'package:tasks/src/core/keys.dart';

import '../category_list/category_list_page.dart';
import '../important_task_list/important_task_list_page.dart';
import '../planned/planned_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  /// Create a HomePage widget.
  HomePage() : super(key: Keys.homePage);

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [
    SettingsPage(),
    ImportantTaskListPage(),
    PlannedPage(),
    CategoryListPage(),
  ];

  int current;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.current = 2;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(HomePage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  void onTapped(int index) {
    setState(() {
      this.current = index;
    });
  }

  /// Build the widget with this state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.screens.elementAt(this.current),
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
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            title: Text('Important'),
            icon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            title: Text('Planned'),
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            title: Text('Category'),
            icon: Icon(Icons.style),
          ),
        ],
        onTap: this.onTapped,
      ),
    );
  }
}
