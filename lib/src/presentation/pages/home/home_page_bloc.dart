import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

/// Home Page Business Logic Component.
class HomePageBloc implements BlocContract {
  final _controllerImportantTasks = StreamController<List<TaskModel>>.broadcast();
  Sink get sinkImportantTasks => _controllerImportantTasks.sink;
  Stream get streamImportantTasks => _controllerImportantTasks.stream;

  TaskRepository _taskRepository;

  HomePageBloc() {
    this._taskRepository = TaskRepository();
  }

  /// Update a task.
  void updateTask(TaskModel object) {
    this._taskRepository.update(object.toMap()).then((_) {
      this.refreshImportantTasks();
    });
  }

  /// Refresh important task list.
  void refreshImportantTasks() {
    this._taskRepository.allImportantTasks().then((tasks) {
      List<TaskModel> result = [];

      tasks.forEach((task) {
        result.add(TaskModel.from(task));
      });

      // Sinking important task list to stream.
      sinkImportantTasks.add(result);
    });
  }

  @override
  void dispose() {
    this._controllerImportantTasks.close();
  }
}
