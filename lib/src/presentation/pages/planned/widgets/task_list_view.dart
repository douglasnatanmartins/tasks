import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'group_list_tile.dart';

class TaskListView extends StatefulWidget {
  TaskListView({
    Key key,
    @required this.data,
    @required this.onChanged,
    @required this.whenOnTap,
  }): assert(data != null),
      assert(onChanged != null),
      assert(whenOnTap != null),
      super(key: key);

  final Map<String, List<TaskModel>> data;
  final ValueChanged<TaskModel> onChanged;
  final Function whenOnTap;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  Map<String, List<TaskModel>> data;

  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  @override
  void didUpdateWidget(TaskListView oldWidget) {
    if (oldWidget.data != this.widget.data) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<GroupListTile> children = <GroupListTile>[];

    this.data.forEach((String title, List<TaskModel> tasks) {
      if (tasks.length > 0) {
        children.add(
          GroupListTile(
            title: title,
            items: tasks,
            onChanged: this.widget.onChanged,
            whenOnTap: this.widget.whenOnTap,
          ),
        );
      }
    });

    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: children,
    );
  }
}
