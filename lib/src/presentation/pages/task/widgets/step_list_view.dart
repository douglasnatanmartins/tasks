import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';
import 'package:tasks/src/presentation/pages/task/task_controller.dart';

import 'step_list_tile.dart';

class StepListView extends StatelessWidget {
  /// Create a StepListView widget.
  StepListView({
    Key key,
    @required this.taskId,
    @required this.items,
  }): super(key: key);

  final List<StepEntity> items;
  final int taskId;

  /// Build the StepListView widget.
  @override
  Widget build(BuildContext context) {
    final com = Component.of<TaskController>(context);
    List<StepListTile> tiles = <StepListTile>[];

    // Add exists steps.
    if (this.items != null) {
      for (var item in this.items) {
        tiles.add(this.buildItem(item, com));
      }
    }

    tiles.add(
      this.buildItem(
        StepEntity(
          id: null,
          message: null,
          taskId: this.taskId,
          isDone: false,
        ),
        com,
      )
    );

    return Container(
      child: Column(
        children: tiles,
      ),
    );
  }

  Widget buildItem(StepEntity item, StepManagerContract controller) {
    return StepListTile(
      key: Key(item.id.toString()),
      data: item,
      onChanged: (StepEntity step) {
        if (step.id == null) {
          if (step.message.isNotEmpty) {
            controller.addStep(step);
          }
        } else {
          if (step.message.isEmpty) {
            controller.deleteStep(item);
          } else {
            controller.updateStep(item, step);
          }
        }
      },
    );
  }
}
