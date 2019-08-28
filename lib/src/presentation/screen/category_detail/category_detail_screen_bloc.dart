import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/task_list_model.dart';

class CategoryDetailScreenBloc {
  final _action = StreamController.broadcast();
  Sink get action => _action.sink;
  Stream get stream => _action.stream;
  final _actionOfList = StreamController.broadcast();
  Sink get actionOfList => _actionOfList.sink;
  Stream get streamOfList => _actionOfList.stream;

  CategoryModel category;
  List<TaskListModel> taskLists;

  CategoryDetailScreenBloc({@required CategoryModel category}) {
    this.category = category;
    this.taskLists = category.allList;
  }

  void updateCategory(CategoryModel category) {
    this.category = category;
    passCategory();
  }

  void passCategory() {
    action.add(category);
  }

  void addNewList(TaskListModel list) {
    category.addTaskList(list);
    passLists();
  }

  void passLists() {
    actionOfList.add(taskLists);
  }

  void dispose() {
    _action.close();
    _actionOfList.close();
  }
}
