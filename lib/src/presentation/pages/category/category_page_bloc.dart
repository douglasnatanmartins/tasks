import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';

/// Category Page Business Logic Component.
class CategoryPageBloc implements BlocContract {
  // Stream of the category.
  final _controllerCategory = StreamController<CategoryModel>();
  Sink get sinkCategory => _controllerCategory.sink;
  Stream get streamCategory => _controllerCategory.stream;

  // Stream of project in the category.
  final _controllerProjects = StreamController<List<ProjectModel>>();
  Sink get sinkProjects => _controllerProjects.sink;
  Stream get streamProjects => _controllerProjects.stream;

  CategoryRepository categoryRepository;
  ProjectRepository projectRepository;
  CategoryModel category;

  CategoryPageBloc(CategoryModel category) {
    this.category = category;
    this.categoryRepository = CategoryRepository();
    this.projectRepository = ProjectRepository();
  }

  /// Action to delete this category
  Future<bool> deleteCategory(CategoryModel category) async {
    return await this.categoryRepository.delete(category.id);
  }

  /// Add new a project
  Future<bool> addProject(ProjectModel project) async {
    bool result = await this.projectRepository.add(project.toMap());
    if (result) {
      this.refreshProjects();
    }
    return result;
  }

  /// Delete a project.
  Future<bool> deleteProject(ProjectModel project) async {
    bool result = await this.projectRepository.delete(project.id);
    if (result) {
      this.refreshProjects();
    }
    return result;
  }

  /// Update project object.
  Future<bool> updateProject(ProjectModel project) async {
    bool result = await this.projectRepository.update(project.toMap());
    if (result) {
      this.refreshProjects();
    }
    return result;
  }

  /// Refresh the category.
  Future<void> refreshCategory() async {
    final data = await this.categoryRepository.getCategoryById(this.category.id);
    if (data != null) {
      this.sinkCategory.add(CategoryModel.from(data));
    }
  }

  /// Refresh project list.
  Future<void> refreshProjects() async {
    final data = await this.projectRepository.getProjectsByCategoryId(this.category.id);
    List<ProjectModel> projects = [];
    data.forEach((Map<String, dynamic> project) {
      projects.add(ProjectModel.from(project));
    });
    this.sinkProjects.add(projects);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    this._controllerCategory.close();
    this._controllerProjects.close();
  }
}
