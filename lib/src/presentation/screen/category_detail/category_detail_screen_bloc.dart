import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';

class CategoryDetailScreenBloc {
  final _controllerOfCategory = StreamController.broadcast();
  Sink get sinkOfCategory => _controllerOfCategory.sink;
  Stream get streamOfCategory => _controllerOfCategory.stream;

  final _controllerOfProjects = StreamController.broadcast();
  Sink get sinkOfProjects => _controllerOfProjects.sink;
  Stream get streamOfProjects => _controllerOfProjects.stream;

  CategoryRepository _categoryRepository = CategoryRepository();
  ProjectRepository _projectRepository = ProjectRepository();
  CategoryModel _category;

  CategoryDetailScreenBloc({@required CategoryModel category}) {
    _category = category;
  }

  Future<List<ProjectModel>> getAllProject() async {
    return await _projectRepository.getByCategoryId(_category.id);
  }

  /// Update category and sinking updated category to stream.
  void updateCategory(CategoryModel category) {
    _category = category;
    _sinkingCategory();
  }

  /// Add project to category.
  void addProject(ProjectModel project) {
    _projectRepository.add(project);
    _sinkingProjects();
  }

  void deleteProject(ProjectModel project) {
    _projectRepository.delete(project);
    _sinkingProjects();
  }

  int countNotDoneTaskInProject(ProjectModel project) {
    int count = 0;
    // project.tasks.forEach((task) {
    //   if (!task.done) {
    //     count++;
    //   }
    // });
    return count;
  }

  void _sinkingCategory() {
    _categoryRepository.update(_category);
    sinkOfCategory.add(_category);
  }

  void _sinkingProjects() {
    _projectRepository.getByCategoryId(_category.id).then((projects) {
      sinkOfProjects.add(projects);
    });
  }

  void dispose() {
    _controllerOfProjects.close();
    _controllerOfCategory.close();
  }
}
