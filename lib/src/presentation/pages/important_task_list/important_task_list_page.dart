import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';

import 'important_task_list_controller.dart';
import 'important_task_list_layout.dart';

class ImportantTaskListPage extends StatelessWidget {
  /// Create a ImportantTaskListPage widget.
  ImportantTaskListPage({
    Key key,
  }): super(key: key);

  /// Build the ImportantTaskListPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<ImportantTaskListController>(
      creator: (context) => ImportantTaskListController(),
      disposer: (context, component) => component.dispose(),
      child: ImportantTaskListLayout(),
    );
  }
}
