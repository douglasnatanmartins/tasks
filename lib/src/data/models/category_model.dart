import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/task_list_model.dart';

class CategoryModel {
  String _title;
  String _description;
  List<TaskListModel> _lists;

  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  List<TaskListModel> get allList => _lists;
  set allList(List<TaskListModel> lists) => _lists = lists;

  CategoryModel({@required String title, String description = "", List<TaskListModel> lists}) {
    _title = title;
    _description = description;
    _lists = lists != null ? lists : [];
  }

  TaskListModel addTaskList(TaskListModel list) {
    _lists.add(list);
    return list;
  }
}
