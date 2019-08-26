import 'package:flutter/material.dart';
import 'package:tasks/screens/category_list_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      home: CategoryListScreen(),
      theme: ThemeData(
        primaryColor: Colors.green
      )
    );
  }
}