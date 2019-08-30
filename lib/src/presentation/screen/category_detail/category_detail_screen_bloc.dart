import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';

class CategoryDetailScreenBloc {
  final _controllerOfCategory = StreamController.broadcast();
  Sink get sinkOfCategory => _controllerOfCategory.sink;
  Stream get streamOfCategory => _controllerOfCategory.stream;

  final _controllerOfProjects = StreamController.broadcast();
  Sink get sinkOfProjects => _controllerOfProjects.sink;
  Stream get streamOfProjects => _controllerOfProjects.stream;

  CategoryEntity _category;

  CategoryDetailScreenBloc({@required CategoryEntity category}) {
    _category = category;
  }

  /// Update category and sinking updated category to stream.
  void updateCategory(CategoryEntity category) {
    _category = category;
    _sinkingCategory();
  }

  /// Add project to category.
  void addProject(ProjectEntity project) {
    _category.addProject(project);
    _sinkingProjects();
  }

  void _sinkingCategory() => sinkOfCategory.add(_category);
  void _sinkingProjects() => sinkOfProjects.add(_category.projects);

  void dispose() {
    _controllerOfProjects.close();
    _controllerOfCategory.close();
  }
}
