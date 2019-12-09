import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

class ImportantTaskListController extends Controller with TaskManagerContract {
  ImportantTaskListController() {
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

  List<TaskEntity> _tasks = <TaskEntity>[];

  @override
  Future<bool> addTask(TaskEntity entity) {
    return null;
  }

  @override
  Future<bool> deleteTask(TaskEntity entity) async {
    final result = await this._taskRepository.deleteTask(entity);
    if (result) {
      this._tasks.remove(entity);
      this.pushTasks();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity previous, TaskEntity current) async {
    final result = await this._taskRepository.updateTask(current);

    if (result) {
      // When the task is not important
      if (!current.isImportant) {
        this._tasks.remove(previous);
      } else {
        int index = this._tasks.indexOf(previous);
        this._tasks[index] = current;
      }

      this.pushTasks();
    }

    return result;
  }

  Future<void> _fetchTasks() async {
    this._tasks = await this._taskRepository.getAllImportantTask();
  }

  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  @override
  void dispose() {
    _tasksController.close();
  }
}
