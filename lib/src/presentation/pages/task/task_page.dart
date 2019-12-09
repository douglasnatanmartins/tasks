import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

import 'task_controller.dart';
import 'task_layout.dart';

class TaskPage extends StatefulWidget {
  /// Create a TaskPage widget.
  /// 
  /// The [data] argument must not be null.
  TaskPage({
    Key key,
    @required this.data,
  }): assert(data != null),
      super(key: key);

  final TaskEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskController controller;
  TaskEntity data;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.controller = TaskController(this.data);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    // Close controller component.
    this.controller.dispose();
    super.dispose();
  }

  void changeEntity(TaskEntity entity) {
    this.data = entity;
  }

  /// Build the TaskPage widget with this state.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final manager = Provider.of<TaskManagerContract>(context);
        await manager.updateTask(this.widget.data, this.data);
        return true;
      },
      child: Provider<TaskController>.component(
        component: this.controller,
        child: TaskLayout(
          data: this.data,
          onChanged: this.changeEntity,
        ),
      ),
    );
  }
}
