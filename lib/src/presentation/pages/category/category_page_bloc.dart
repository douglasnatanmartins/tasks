import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';

class CategoryPageBloc implements BlocContract {
  final _controllerCategory = StreamController<CategoryModel>();
  Sink get sinkCategory => _controllerCategory.sink;
  Stream get streamCategory => _controllerCategory.stream;

  final _controllerProjects = StreamController<List<ProjectModel>>();
  Sink get sinkProjects => _controllerProjects.sink;
  Stream get streamProjects => _controllerProjects.stream;

  CategoryRepository _categoryRepository;
  ProjectRepository _projectRepository;
  CategoryModel _category;

  CategoryPageBloc(CategoryModel category) {
    this._category = category;
    this._categoryRepository = CategoryRepository();
    this._projectRepository = ProjectRepository();
  }

  /// Action to delete this category
  void deleteCategory(CategoryModel category) {
    _categoryRepository.delete(category.id);
  }

  /// Add new a project
  void addProject(ProjectModel project) {
    _projectRepository.add(project.toMap()).then((_) {
      refreshProjects();
    });
  }

  /// Delete a project.
  void deleteProject(ProjectModel project) {
    _projectRepository.delete(project.id).then((_) {
      refreshProjects();
    });
  }

  /// Update project object.
  void updateProject(ProjectModel project) {
    _projectRepository.update(project.toMap()).then((_) {
      refreshProjects();
    });
  }

  /// Refresh category.
  void refreshCategory() {
    _categoryRepository.getCategoryById(_category.id).then((category) {
      // Sink category to stream
      sinkCategory.add(CategoryModel.from(category));
    });
  }

  /// Refresh list projects.
  void refreshProjects() {
    _projectRepository.getProjectsByCategoryId(this._category.id).then((projects) {
      List<ProjectModel> data = [];
      projects.forEach((project) {
        data.add(ProjectModel.from(project));
      });

      // Sink data to stream
      sinkProjects.add(data);
    });
  }

  @override
  void dispose() {
    _controllerCategory.close();
    _controllerProjects.close();
  }
}
