import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

class ImportantPageBloc implements BlocContract {
  final _controllerImportantTasks = StreamController<List<TaskModel>>.broadcast();
  Sink get sinkImportantTasks => _controllerImportantTasks.sink;
  Stream get streamImportantTasks => _controllerImportantTasks.stream;

  TaskRepository _taskRepository;

  ImportantPageBloc() {
    _taskRepository = TaskRepository();
  }

  void updateTask(TaskModel object) {
    _taskRepository.update(object.toMap()).then((_) {
      refreshImportantTasks();
    });
  }

  void refreshImportantTasks() {
    _taskRepository.allImportantTasks().then((tasks) {
      List<TaskModel> result = [];
      tasks.forEach((task) {
        result.add(TaskModel.from(task));
      });

      // Sinking to stream
      sinkImportantTasks.add(result);
    });
  }

  @override
  void dispose() {
    _controllerImportantTasks.close();
  }
}
