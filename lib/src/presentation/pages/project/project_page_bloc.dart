import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

/// Project Page Business Logic Component.
class ProjectPageBloc implements BlocContract {
  final _controllerTasks = StreamController<List<TaskModel>>();
  Sink get sinkTasks => _controllerTasks.sink;
  Stream get streamTasks => _controllerTasks.stream;

  TaskRepository _taskRepository;
  ProjectModel _project;

  ProjectPageBloc(ProjectModel project) {
    this._project = project;
    this._taskRepository = TaskRepository();
  }

  /// Add a task into database.
  void addTask(TaskModel task) {
    this._taskRepository.add(task.toMap()).then((result) {
      this.refreshTasks();
    });
  }

  /// Delete a task from database.
  void deleteTask(TaskModel task) {
    this._taskRepository.delete(task.id).then((result) {
      this.refreshTasks();
    });
  }

  /// Update a task.
  void updateTask(TaskModel task) {
    this._taskRepository.update(task.toMap()).then((result) {
      this.refreshTasks();
    });
  }

  /// Refresh task list in the project.
  void refreshTasks() {
    this._taskRepository.getTasksByProjectId(this._project.id).then((tasks) {
      List<TaskModel> data = [];

      tasks.forEach((task) {
        data.add(TaskModel.from(task));
      });

      // Sinking task list in the project to stream.
      sinkTasks.add(data);
    });
  }

  @override
  void dispose() {
    this._controllerTasks.close();
  }
}
