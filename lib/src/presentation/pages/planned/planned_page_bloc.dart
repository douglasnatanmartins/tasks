import 'dart:async';

import 'package:intl/intl.dart';
import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

/// Home Page Business Logic Component.
class PlannedPageBloc implements BLoCContract {
  PlannedPageBloc() {
    this.taskRepository = TaskRepository();
  }

  TaskRepository taskRepository;

  final _controllerTasks = StreamController<Map<String, List<TaskModel>>>.broadcast();
  Sink get sinkTasks => _controllerTasks.sink;
  Stream get streamTasks => _controllerTasks.stream;

  /// Update a task.
  Future<bool> updateTask(TaskModel task) async {
    bool result = await this.taskRepository.update(task.toMap());
    return result;
  }

  Future<void> fetchAll() async {
    final data = await this.taskRepository.allTaskWithDueDate();
    final Map<String, List<TaskModel>> tasks = {};

    if (data.length == 0) {
      this.sinkTasks.add(tasks);
      return;
    }

    // Get date with format (YYYY-MM-DD)
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    DateTime current = today;
    bool group = true;
    String currentGroup;

    data.forEach((Map<String, dynamic> task) {
      int present = DateTime.parse(task['due_date']).difference(today).inDays;

      if (present >= 0) {
        final TaskModel model = TaskModel.from(task);
        int difference = current.difference(model.dueDate).inDays;

        if (difference != 0) {
          group = true;
          current = model.dueDate;
        }

        if (group) {
          if (present == 0) {
            currentGroup = 'Today';
          } else if (present == 1) {
            currentGroup = 'Tomorrow';
          } else {
            currentGroup = DateFormat.yMMMd().format(current);
          }
          tasks[currentGroup] = <TaskModel>[];
          group = false;
        }

        tasks[currentGroup].add(model);
      }
    });

    this.sinkTasks.add(tasks);
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    _controllerTasks.close();
  }
}
