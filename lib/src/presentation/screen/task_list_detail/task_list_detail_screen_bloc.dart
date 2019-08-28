import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/task_list_model.dart';
import 'package:tasks/src/data/models/task_model.dart';

class TaskListDetailScreenBloc {
  final _action = StreamController.broadcast();
  Sink get action => _action.sink;
  Stream get stream => _action.stream;
  final _actionOfTasks = StreamController.broadcast();
  Sink get actionOfTasks => _actionOfTasks.sink;
  Stream get streamOfTasks => _actionOfTasks.stream;
  TaskListModel list;
  List<TaskModel> tasks;

  TaskListDetailScreenBloc({@required TaskListModel list}) {
    this.list = list;
    this.tasks = list.tasks;
  }

  void addTask(TaskModel task) {
    tasks.add(task);
    passList();
  }

  void onFinished(int index, bool checked) {
    tasks[index].finished = checked;
    passList();
  }

  void passList() {
    actionOfTasks.add(tasks);
  }

  void dispose() {
    _actionOfTasks.close();
    _action.close();
  }
}
