import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'group_list_tile.dart';

class TaskListView extends StatelessWidget {
  /// Create a TaskListView widget.
  TaskListView({
    Key key,
    @required this.items,
  }): assert(items != null),
      super(key: key);

  final Map<String, List<TaskModel>> items;

  /// Build the TaskListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      scrollDirection: Axis.vertical,
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        final key = this.items.keys.elementAt(index);
        final data = this.items[key];
        return GroupListTile(
          title: key,
          items: data,
        );
      }
    );
  }
}
