import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

/// Project Page Business Logic Component.
class ProjectController extends Controller with TaskManagerContract {
  ProjectController(this.project) {
    _fetchTasks().then((_) => pushTasks());
  }

  final _taskRepository = GetTaskRepository().getRepository();
  final _taskListController = StreamController<List<TaskEntity>>.broadcast();
  Stream<List<TaskEntity>> get tasks => _taskListController.stream;

  ProjectEntity project;
  List<TaskEntity> _tasks = <TaskEntity>[];

  @override
  Future<bool> createTask(TaskEntity data) async {
    bool result = await _taskRepository.createTask(data);
    if (result) {
      await _fetchTasks();
      pushTasks();
    }

    return result;
  }

  @override
  Future<bool> deleteTask(TaskEntity data) async {
    bool result = await _taskRepository.deleteTask(data);
    if (result) {
      _tasks.remove(data);
      pushTasks();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity current, TaskEntity previous) async {
    bool result = await _taskRepository.updateTask(current);

    if (result) {
      await _fetchTasks();
      pushTasks();
    }

    return result;
  }

  /// Refresh task list in the project.
  Future<void> pushTasks() async {
    _taskListController.add(_tasks);
  }

  /// Fetch all task from database.
  Future<void> _fetchTasks() async {
    _tasks = await _taskRepository.getAllTaskByProjectId(project.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _taskListController.close();
  }
}
