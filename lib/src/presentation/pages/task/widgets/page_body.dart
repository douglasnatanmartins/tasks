import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';

import '../task_controller.dart';
import 'step_list_tile.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
    @required this.model,
  }): super(key: key);

  final TaskModel model;

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<TaskController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.steps,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            List<StepListTile> tiles = <StepListTile>[];

            snapshot.data.forEach((step) {
              tiles.add(this._buildItem(step, component));
            });

            tiles.add(this._buildItem(
              StepModel(id: null, title: '', done: false, taskId: this.model.id),
              component,
            ));

            return Container(
              child: Column(
                children: tiles,
              ),
            );
          }
        },
      ),
    );
  }

  /// Build a children in listview.
  Widget _buildItem(StepModel step, TaskController controller) {
    return StepListTile(
      key: Key(step.id.toString()),
      data: step,
      onChanged: (StepModel newModel) {
        if (step.title == null) {
          controller.deleteStep(step);
        } else {
          if (step.id == null) {
            controller.addStep(step);
          } else {
            controller.updateStep(step, newModel);
          }
        }
      },
    );
  }
}
