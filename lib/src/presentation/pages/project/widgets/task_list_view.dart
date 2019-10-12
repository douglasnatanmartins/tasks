import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'task_list_tile.dart';

class TaskListView extends StatefulWidget {
  final List<TaskModel> data;
  final ValueChanged<TaskModel> onChanged;
  final Function whenOpened;

  TaskListView({
    Key key,
    @required this.data,
    @required this.onChanged,
    @required this.whenOpened
  }): assert(data != null),
      assert(onChanged != null),
      assert(whenOpened != null),
      super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<TaskModel> tasks;

  @override
  void initState() {
    super.initState();
    this.tasks = this.widget.data;
  }

  @override
  void didUpdateWidget(TaskListView oldWidget) {
    if (oldWidget.data != this.widget.data) {
      this.tasks = this.widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        itemCount: tasks.length,
        separatorBuilder: (BuildContext content, int index) {
          return Divider(
            color: Colors.white.withOpacity(0.85),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return this.buildItem(task);
        }
      ),
    );
  }

  Widget buildItem(TaskModel task) {
    return TaskListTile(
      task: task,
      onChanged: this.widget.onChanged,
      whenOpened: this.widget.whenOpened,
    );
  }
}
