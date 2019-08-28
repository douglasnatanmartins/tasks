import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/task_model.dart';

class TaskListModel {
  String _title;
  String _description;
  List<TaskModel> _tasks;

  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  List<TaskModel> get tasks => _tasks;
  set tasks(List<TaskModel> tasks) => _tasks = tasks;

  TaskListModel({@required String title, String description, List<TaskModel> tasks}) {
    _title = title;
    _description = description;
    _tasks = tasks != null ? tasks : [];
  }
}
