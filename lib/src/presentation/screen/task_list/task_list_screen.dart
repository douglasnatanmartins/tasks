import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskListScreenState();
  }
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text("List")
      ),
      body: SafeArea(
        child: ListView(
        )
      )
    );
  }
}
