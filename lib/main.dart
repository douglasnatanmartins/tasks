import 'package:flutter/material.dart';
import 'package:tasks/screens/task_list_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      home: TaskListScreen()
    );
  }
}
