import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

import '../task_controller.dart';
import 'step_list_view.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
    @required this.data,
  }): super(key: key);

  final TaskEntity data;

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<TaskController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.steps,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return StepListView(
            taskId: data.id,
            items: snapshot.data,
          );
        },
      ),
    );
  }
}
