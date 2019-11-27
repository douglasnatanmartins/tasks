import 'dart:async';

import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

/// Project Page Business Logic Component.
class ProjectController implements TasksControllerInterface {
  ProjectController(ProjectModel project) {
    this.project = project;
    this._fetchTasks().then((result) {
      this.pushTasks();
    });
  }

  final TaskRepository _taskRepository = TaskRepository();
  ProjectModel project;

  final _tasksController = StreamController<List<TaskModel>>();
  Stream get tasks => _tasksController.stream;
  List<TaskModel> _tasks = <TaskModel>[];

  /// Add a task into database.
  Future<bool> addTask(TaskModel task) async {
    bool result = await this._taskRepository.add(task.toMap());
    if (result) {
      await this._fetchTasks();
      this.pushTasks();
    }
    return result;
  }

  /// Delete a task from database.
  Future<bool> deleteTask(TaskModel task) async {
    bool result = await this._taskRepository.delete(task.id);
    if (result) {
      this._tasks.remove(task);
      this.pushTasks();
    }
    return result;
  }

  /// Update a task.
  Future<bool> updateTask(TaskModel task) async {
    bool result = await this._taskRepository.update(task.toMap());
    if (result) {
      await this._fetchTasks();
      this.pushTasks();
    }
    return result;
  }

  /// Refresh task list in the project.
  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  Future<void> _fetchTasks() async {
    final data = await this._taskRepository.getTasksByProjectId(this.project.id);
    this._tasks = data.map((Map<String, dynamic> item) {
      return TaskModel.from(item);
    }).toList();
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _tasksController.close();
  }
}
