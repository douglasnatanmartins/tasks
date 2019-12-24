import 'dart:async';
import 'package:meta/meta.dart';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/usecases/get_project_repository.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';

/// The Business Logic Component for the Category Page.
class CategoryController implements Controller, ProjectManagerContract {
  /// Constructor of Business Logic Component for the Category Page.
  /// 
  /// The [category] argument must not be null.
  CategoryController({
    @required CategoryEntity category,
    @required CategoryManagerContract manager,
  }): assert(category != null),
      assert(manager != null),
      _category = category,
      _categoryManager = manager {
    _fetchProjects().then((_) => _pushProjectList());
  }

  final CategoryManagerContract _categoryManager;
  final _projectRepository = GetProjectRepository().getRepository();
  final _taskRepository = GetTaskRepository().getRepository();

  final _categorySubject = StreamController<CategoryEntity>.broadcast();
  Stream<CategoryEntity> get categoryStream {
    return _categorySubject.stream;
  }

  final _projectListSubject = StreamController<List<ProjectEntity>>.broadcast();
  Stream<List<ProjectEntity>> get projectListStream {
    return _projectListSubject.stream;
  }

  CategoryEntity _category;
  CategoryEntity get category => _category;

  List<ProjectEntity> _projects = <ProjectEntity>[];
  List<ProjectEntity> get projects => _projects;

  Future<bool> deleteCategory() {
    return _categoryManager.deleteCategory(_category);
  }

  Future<bool> updateCategory(CategoryEntity newCategory) async {
    bool result = await _categoryManager.updateCategory(newCategory, _category);
    if (result) {
      _category = newCategory;
      _pushCategory();
    }

    return result;
  }

  @override
  Future<bool> createProject(ProjectEntity data) async {
    bool result = await _projectRepository.createProject(data);
    if (result) {
      await _fetchProjects();
      _pushProjectList();
    }

    return result;
  }

  @override
  Future<bool> deleteProject(ProjectEntity data) async {
    bool result = await _projectRepository.deleteProject(data);
    if (result) {
      await _fetchProjects();
      _pushProjectList();
    }

    return result;
  }

  @override
  Future<bool> updateProject(ProjectEntity current, ProjectEntity previous) async {
    bool result = await _projectRepository.updateProject(current);
    if (result) {
      await _fetchProjects();
      _pushProjectList();
    }

    return result;
  }

  Future<double> getProgressProject(int projectId) async {
    final data = await _taskRepository.getAllTaskByProjectId(projectId);
    double result = 0;
    if (data != null && data.length > 0) {
      int completed = 0;
      for (var task in data) {
        if (task.isDone) completed++;
      }

      result = completed / data.length;
    }

    return result;
  }

  Future<void> _fetchProjects() async {
    _projects = await _projectRepository.getAllProjectByCategoryId(category.id);
  }

  void _pushProjectList() {
    _projectListSubject.add(_projects);
  }

  void _pushCategory() {
    _categorySubject.add(_category);
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    _categorySubject.close();
    _projectListSubject.close();
  }
}
