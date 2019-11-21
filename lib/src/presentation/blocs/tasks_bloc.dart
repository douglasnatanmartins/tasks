import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

enum TaskType {
  Important,
  Planned,
}

class TasksBloc implements BLoCContract {
  TasksBloc() {
    this._typeController.stream.listen((type) {
      this._fetchTasks(type).then((result) {
        this.pushTasks();
      });
    });
  }

  final TaskRepository _repository = TaskRepository();

  final _tasksController = StreamController<List<TaskModel>>.broadcast();
  Stream get tasks => this._tasksController.stream;
  final _typeController = StreamController<TaskType>();
  Sink<TaskType> get event => _typeController.sink;
  List<TaskModel> _tasks;

  /// Update task.
  Future<bool> updateTask(TaskModel oldModel, TaskModel newModel) async {
    bool result = await this._repository.update(newModel.toMap());
    if (result) {
      int index = this._tasks.indexOf(oldModel);
      this._tasks[index] = newModel;
    }
    return result;
  }

  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  Future<void> _fetchTasks(TaskType type) async {
    if (type == TaskType.Important) {
      final data = await this._repository.allImportantTasks();
      this._tasks = data.map((Map<String, dynamic> item) {
        return TaskModel.from(item);
      }).toList();
    } else {
      final data = await this._repository.allTaskWithDueDate();
      this._tasks = data.map((Map<String, dynamic> item) {
        return TaskModel.from(item);
      }).toList();
    }
  }

  @override
  void dispose() {
    _tasksController.close();
    _typeController.close();
  }
}
