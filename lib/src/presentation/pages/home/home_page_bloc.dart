import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

/// Home Page Business Logic Component.
class HomePageBloc implements BlocContract {
  final _controllerImportantTasks = StreamController<List<TaskModel>>.broadcast();
  Sink get sinkImportantTasks => _controllerImportantTasks.sink;
  Stream get streamImportantTasks => _controllerImportantTasks.stream;

  TaskRepository taskRepository;

  HomePageBloc() {
    this.taskRepository = TaskRepository();
  }

  /// Update a task.
  Future<bool> updateTask(TaskModel task) async {
    bool result = await this.taskRepository.update(task.toMap());
    if (result) {
      this.refreshImportantTasks();
    }
    return result;
  }

  /// Refresh important task list.
  Future<void> refreshImportantTasks() async {
    final data = await this.taskRepository.allImportantTasks();
    List<TaskModel> tasks = [];
    data.forEach((Map<String, dynamic> task) {
      tasks.add(TaskModel.from(task));
    });
    this.sinkImportantTasks.add(tasks);
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    this._controllerImportantTasks.close();
  }
}
