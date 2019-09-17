import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

class HomePageBloc implements BlocContract {
  final _controllerAnnouncement = StreamController();
  Sink get sinkAnnouncement => _controllerAnnouncement.sink;
  Stream get streamAnnouncement => _controllerAnnouncement.stream;

  final _controllerCategories = StreamController<List<CategoryModel>>.broadcast();
  Sink get sinkCategories => _controllerCategories.sink;
  Stream get streamCategories => _controllerCategories.stream;

  final _controllerTasks = StreamController<List<TaskModel>>.broadcast();
  Sink get sinkTasks => _controllerTasks.sink;
  Stream get streamTasks => _controllerTasks.stream;

  CategoryRepository _categoryRepository;
  TaskRepository _taskRepository;

  HomePageBloc() {
    _taskRepository = TaskRepository();
    _categoryRepository = CategoryRepository();
  }

  void addCategory(CategoryModel category) {
    _categoryRepository.add(category.toMap()).then((category) {
      refreshCategories();
    });
  }

  void announceImportantTasks() {
    _taskRepository.allImportantTasks().then((tasks) {
      String result;
      if (tasks.length == 0) {
        result = 'You not have important task.';
      } else if (tasks.length == 1) {
        result = 'You have one important task.';
      } else {
        result = 'You have ' + tasks.length.toString() + ' important tasks.';
      }
      sinkAnnouncement.add(result);
    });
  }

  void updateTask(TaskModel object) {
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

  void refreshCategories() {
    _categoryRepository.all().then((categories) {
      List<CategoryModel> data = [];
      categories.forEach((category) {
        data.add(CategoryModel.from(category));
      });
      sinkCategories.add(data);
    });
  }

  @override
  void dispose() {
    _controllerTasks.close();
    _controllerCategories.close();
    _controllerAnnouncement.close();
  }
}
