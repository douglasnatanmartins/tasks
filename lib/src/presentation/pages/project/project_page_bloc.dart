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

  TaskRepository taskRepository;
  ProjectModel project;

  ProjectPageBloc(ProjectModel project) {
    this.project = project;
    this.taskRepository = TaskRepository();
  }

  /// Add a task into database.
  Future<bool> addTask(TaskModel task) async {
    bool result = await this.taskRepository.add(task.toMap());
    if (result) {
      await this.refreshTasks();
    }
    return result;
  }

  /// Delete a task from database.
  Future<bool> deleteTask(TaskModel task) async {
    bool result = await this.taskRepository.delete(task.id);
    if (result) {
      await this.refreshTasks();
    }
    return result;
  }

  /// Update a task.
  Future<bool> updateTask(TaskModel task) async {
    bool result = await this.taskRepository.update(task.toMap());
    if (result) {
      await this.refreshTasks();
    }
    return result;
  }

  /// Refresh task list in the project.
  Future<void> refreshTasks() async {
    final data = await this.taskRepository.getTasksByProjectId(this.project.id);
    List<TaskModel> tasks = [];
    data.forEach((Map<String, dynamic> task) {
      tasks.add(TaskModel.from(task));
    });
    this.sinkTasks.add(tasks);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    this._controllerTasks.close();
  }
}
