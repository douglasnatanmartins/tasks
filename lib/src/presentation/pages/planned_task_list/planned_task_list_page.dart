import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/pages/planned_task_list/planned_task_list_controller.dart';

import 'planned_task_list_controller.dart';
import 'planned_task_list_layout.dart';

class PlannedTaskListPage extends StatelessWidget {
  /// Create a PlannedTaskListPage widget.
  PlannedTaskListPage({
    Key key,
  }): super(key: key);

  /// Build the PlannedTaskListPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<PlannedTaskListController>(
      creator: (context) => PlannedTaskListController(),
      disposer: (context, controller) => controller?.dispose(),
      child: PlannedTaskListLayout(),
    );
  }
}
