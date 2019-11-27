import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';
import 'package:tasks/src/presentation/pages/project/project_controller.dart';

import 'task_list_tile.dart';

class TaskListView extends StatelessWidget {
  TaskListView({
    @required this.items,
  }): assert(items != null);

  final List<TaskModel> items;

  @override
  Widget build(BuildContext context) {
    final component = Component.of<ProjectController>(context);
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: this.items.length,
      separatorBuilder: (BuildContext content, int index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Component<TasksControllerInterface>.value(
          value: component,
          child: TaskListTile(
            model: this.items.elementAt(index),
            onChanged: (TaskModel model) {
              final controller = Component.of<ProjectController>(context);
              controller.updateTask(model);
            },
          ),
        );
      },
    );
  }
}
