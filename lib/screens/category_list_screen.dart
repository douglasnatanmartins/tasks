import 'package:flutter/material.dart';
import 'package:tasks/models/category.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task_list_screen.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListScreen();
  }
}

class _CategoryListScreen extends State<CategoryListScreen> {
  List<Category> categories = [
    Category(
      title: "Home Work",
      description: "Some description",
      tasks: [
        Task(title: "Item 1"),
        Task(title: "Item 2")
      ]
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          Category category = categories[index];
          return ListTile(
            title: Text(category.title),
            subtitle: Text(category.description),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListScreen(category)));
            }
          );
        }
      )
    );
  }
}
