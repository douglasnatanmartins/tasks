import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

/// Project Page Business Logic Component.
class ProjectController extends Controller with TaskManagerContract {
  ProjectController(this.project) {
    this._taskRepository = GetTaskRepository().getRepository();
    this._tasksController = StreamController<List<TaskEntity>>.broadcast();

    // Initial
    this._fetchTasks().then((result) {
      this.pushTasks();
    });
  }

  TaskRepositoryContract _taskRepository;
  StreamController<List<TaskEntity>> _tasksController;
  Stream<List<TaskEntity>> get tasks => this._tasksController.stream;
  ProjectEntity project;
  List<TaskEntity> _tasks = <TaskEntity>[];

  /// Add a task into database.
  Future<bool> addTask(TaskEntity entity) async {
    bool result = await this._taskRepository.createTask(entity);
    if (result) {
      await this._fetchTasks();
      this.pushTasks();
    }
    return result;
  }

  /// Delete a task from database.
  Future<bool> deleteTask(TaskEntity entity) async {
    bool result = await this._taskRepository.deleteTask(entity);
    if (result) {
      this._tasks.remove(entity);
      this.pushTasks();
    }
    return result;
  }

  /// Update a task.
  Future<bool> updateTask(TaskEntity previous, TaskEntity current) async {
    bool result = await this._taskRepository.updateTask(current);

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

  /// Fetch all task from database.
  Future<void> _fetchTasks() async {
    this._tasks = await this._taskRepository.getAllTaskByProjectId(this.project.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _tasksController.close();
  }
}
