import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskListScreenState();
  }
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(title: 'Flutter Learn'),
    Task(title: 'Hello Flutter'),
    Task(title: 'New Program with Flutter')
  ];

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks List')
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: _buildTaskItem
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("New Task"),
                content: TextField(
                  controller: controller,
                  autofocus: true
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      controller.clear();
                    },
                  ),
                  FlatButton(
                    child: Text("Add"),
                    onPressed: () {
                      setState(() {
                        final task = Task(title: controller.value.text);
                        tasks.add(task);
                        controller.clear();
                        Navigator.of(context).pop();
                      });
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    final task = tasks[index];

    return CheckboxListTile(
      value: task.done,
      title: Text(task.title),
      onChanged: (bool checked) {
        setState(() {
          task.done = checked;
        });
      }
    );
  }
}
