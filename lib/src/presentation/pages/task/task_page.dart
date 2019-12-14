import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

import '../../controllers/task_manager_contract.dart';
import 'task_controller.dart';
import 'task_layout.dart';

class TaskPageArguments {
  TaskPageArguments({
    this.key,
    @required this.manager,
    @required this.task,
  }): assert(manager != null),
      assert(task != null);

  final Key key;
  final TaskManagerContract manager;
  final TaskEntity task;
}

class TaskPage extends StatelessWidget {
  /// Create a TaskPage widget.
  /// 
  /// The [arguments] argument must not be null.
  TaskPage({
    Key key,
    @required this.arguments,
  }): assert(arguments != null),
      super(key: arguments.key);
  
  final TaskPageArguments arguments;

  /// Build the TaskPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<TaskManagerContract>.component(
      component: arguments.manager,
      notifier: (current, previous) => false,
      child: Provider<TaskController>(
        creator: (context) => TaskController(arguments.task),
        disposer: (context, component) => component?.dispose(),
        child: TaskLayout(task: arguments.task),
      ),
    );
  }
}
