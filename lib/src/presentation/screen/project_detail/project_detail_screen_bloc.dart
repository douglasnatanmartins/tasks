import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

class ProjectDetailScreenBloc {
  final _controllerOfProject = StreamController.broadcast();
  Sink get sinkOfProject => _controllerOfProject.sink;
  Stream get streamOfProject => _controllerOfProject.stream;

  final _controllerOfTasks = StreamController.broadcast();
  Sink get sinkOfTasks => _controllerOfTasks.sink;
  Stream get streamOfTasks => _controllerOfTasks.stream;

  ProjectEntity _project;

  ProjectDetailScreenBloc({@required ProjectEntity project}) {
    _project = project;
  }

  void addTask(TaskEntity task) {
    _project.tasks.add(task);
    _sinkingTasks();
  }

  void taskIsDone(TaskEntity task, bool done) {
    int index = _project.tasks.indexOf(task);
    _project.tasks[index].done = done;
    _sinkingTasks();
  }

  void _sinkingProject() => sinkOfProject.add(_project);
  void _sinkingTasks() => sinkOfTasks.add(_project.tasks);

  void dispose() {
    _controllerOfTasks.close();
    _controllerOfProject.close();
  }
}
