import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

class BoardPageBloc implements BlocContract {
  final _controllerTasks = StreamController<List<TaskModel>>();
  Sink get sinkTasks => _controllerTasks.sink;
  Stream get streamTasks => _controllerTasks.stream;

  TaskRepository _taskRepository;

  BoardPageBloc() {
    _taskRepository = TaskRepository();
    refreshTasks();
  }

  void updateTasks(TaskModel object) {
    _taskRepository.update(object.toMap()).then((_) {
      refreshTasks();
    });
  }

  void refreshTasks() {
    _taskRepository.allImportantTasks().then((tasks) {
      List<TaskModel> result = [];
      tasks.forEach((task) {
        result.add(TaskModel.from(task));
      });
      sinkTasks.add(result);
    });
  }

  @override
  void dispose() {
    _controllerTasks.close();
  }
}
