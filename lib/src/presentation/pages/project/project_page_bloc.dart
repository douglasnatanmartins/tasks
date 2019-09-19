import 'dart:async';
import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

class ProjectPageBloc implements BlocContract {
  final _controllerTasks = StreamController<List<TaskModel>>();
  Sink get sinkTasks => _controllerTasks.sink;
  Stream get streamTasks => _controllerTasks.stream;

  TaskRepository _taskRepository;
  ProjectModel _project;

  ProjectPageBloc({@required ProjectModel project}) {
    this._project = project;
    _taskRepository = TaskRepository();
  }

  void addTask(TaskModel task) {
    _taskRepository.add(task.toMap()).then((result) {
      refreshTasks();
    });
  }

  void deleteTask(TaskModel task) {
    _taskRepository.delete(task.id).then((result) {
      refreshTasks();
    });
  }

  void updateTask(TaskModel task) {
    _taskRepository.update(task.toMap()).then((result) {
      refreshTasks();
    });
  }

  void refreshTasks() {
    _taskRepository.getTasksByProjectId(this._project.id).then((tasks) {
      List<TaskModel> data = [];
      tasks.forEach((task) {
        data.add(TaskModel.from(task));
      });
      sinkTasks.add(data);
    });
  }

  @override
  void dispose() {
    _controllerTasks.close();
  }
}
