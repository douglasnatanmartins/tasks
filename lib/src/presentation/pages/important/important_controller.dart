import 'dart:async';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

class ImportantController implements TasksControllerInterface {
  ImportantController() {
    this._fetchTasks().then((result) {
      this.pushTasks();
    });
  }

  final TaskRepository _taskRepository = TaskRepository();
  final _tasksController = StreamController<List<TaskModel>>.broadcast();
  Stream<List<TaskModel>> get tasks => this._tasksController.stream;
  List<TaskModel> _tasks = <TaskModel>[];

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

  Future<void> _fetchTasks() async {
    final data = await this._taskRepository.allImportantTasks();
    this._tasks = data.map((Map<String, dynamic> item) {
      return TaskModel.from(item);
    }).toList();
  }

  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  @override
  void dispose() {
    _tasksController.close();
  }
}
