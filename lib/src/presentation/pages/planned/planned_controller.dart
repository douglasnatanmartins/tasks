import 'dart:async';

import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

/// Home Page Business Logic Component.
class PlannedController implements TasksControllerInterface {
  PlannedController() {
    this._fetchTasks().then((result) {
      this.pushTasks();
    });
  }

  final _taskRepository = TaskRepository();

  final _tasksController = StreamController<Map<String, List<TaskModel>>>.broadcast();
  Stream<Map<String, List<TaskModel>>> get tasks => this._tasksController.stream;
  Map<String, List<TaskModel>> _tasks = Map<String, List<TaskModel>>();

  @override
  Future<bool> addTask(TaskModel model) {
    return null;
  }

  @override
  Future<bool> deleteTask(TaskModel model) {
    return null;
  }

  @override
  Future<bool> updateTask(TaskModel model) async {
    final result = await this._taskRepository.update(model.toMap());
    if (result) {
    }
    return result;
  }

  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  Future<void> _fetchTasks() async {
    final data = await this._taskRepository.allTaskWithDueDate();

    if (data.length == 0) {
      this._tasks = Map<String, List<TaskModel>>();
      return;
    }

    final Map<String, List<TaskModel>> tasks = {};

    // Get date with format (YYYY-MM-DD).
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
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    _tasksController.close();
  }
}
