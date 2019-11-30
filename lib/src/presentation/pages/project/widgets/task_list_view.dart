import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/pages/project/project_controller.dart';

import 'task_list_tile.dart';

class TaskListView extends StatelessWidget {
  TaskListView({
    @required this.items,
  }): assert(items != null);

  final List<TaskEntity> items;

  @override
  Widget build(BuildContext context) {
    final controller = Component.of<ProjectController>(context);
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: this.items.length,
      separatorBuilder: (BuildContext content, int index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final item = this.items.elementAt(index);
        return TaskListTile(
          data: item,
          onChanged: (TaskEntity entity) {
            controller.updateTask(item, entity);
          },
        );
      },
    );
  }
}
