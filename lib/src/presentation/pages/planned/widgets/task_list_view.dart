import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'group_list_tile.dart';

class TaskListView extends StatefulWidget {
  final Map<String, List<TaskModel>> data;
  final ValueChanged<TaskModel> onChanged;

  TaskListView({
    Key key,
    @required this.data,
    @required this.onChanged
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<GroupListTile> children = <GroupListTile>[];

    this.data.forEach((String title, List<TaskModel> tasks) {
      children.add(GroupListTile(
        title: title,
        items: tasks,
        onChanged: this.widget.onChanged
      ));
    });

    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: children
    );
  }
}
