import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

/// The Business Logic Component for the Important Task List Page.
class ImportantTaskListController implements Controller, TaskManagerContract {
  /// Constructor of Business Logic Component for the Important Task List Page.
  ImportantTaskListController() {
    _fetchTasks().then((_) => pushTasks());
  }

  final _taskRepository = GetTaskRepository().getRepository();
  final _taskListController = StreamController<List<TaskEntity>>.broadcast();
  Stream<List<TaskEntity>> get tasks => _taskListController.stream;

  List<TaskEntity> _tasks = <TaskEntity>[];

  @override
  Future<bool> createTask(TaskEntity data) {
    return null;
  }

  @override
  Future<bool> deleteTask(TaskEntity data) async {
    var result = await _taskRepository.deleteTask(data);
    if (result) {
      _tasks.remove(data);
      pushTasks();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity current, TaskEntity previous) async {
    var result = await _taskRepository.updateTask(current);

    if (result) {
      // When the task is not important, remove it from list.
      if (!current.isImportant) {
        _tasks.remove(previous);
      } else {
        int index = _tasks.indexOf(previous);
        _tasks[index] = current;
      }

      pushTasks();
    }

    return result;
  }

  Future<void> _fetchTasks() async {
    _tasks = await _taskRepository.getAllImportantTask();
  }

  Future<void> pushTasks() async {
    _taskListController.add(_tasks);
  }

  @override
  void dispose() {
    _taskListController.close();
  }
}
