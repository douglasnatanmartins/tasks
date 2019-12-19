import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/usecases/get_project_repository.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';

/// The Business Logic Component for the Category Page.
class CategoryController implements Controller, ProjectManagerContract {
  /// Constructor of Business Logic Component for the Category Page.
  /// 
  /// The [category] argument must not be null.
  CategoryController(this.category) {
    _fetchProjects().then((_) {
      pushProjects();
    });
  }

  final _projectRepository = GetProjectRepository().getRepository();
  final _taskRepository = GetTaskRepository().getRepository();
  final _projectListController = StreamController<List<ProjectEntity>>.broadcast();
  Stream<List<ProjectEntity>> get projects => _projectListController.stream;

  final CategoryEntity category;
  List<ProjectEntity> _projects = <ProjectEntity>[];

  @override
  Future<bool> createProject(ProjectEntity data) async {
    bool result = await _projectRepository.createProject(data);
    if (result) {
      await _fetchProjects();
      pushProjects();
    }

    return result;
  }

  @override
  Future<bool> deleteProject(ProjectEntity data) async {
    bool result = await _projectRepository.deleteProject(data);
    if (result) {
      await _fetchProjects();
      pushProjects();
    }

    return result;
  }

  @override
  Future<bool> updateProject(ProjectEntity current, ProjectEntity previous) async {
    bool result = await _projectRepository.updateProject(current);
    if (result) {
      await _fetchProjects();
      pushProjects();
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

  Future<void> pushProjects() async {
    _projectListController.add(_projects);
  }

  Future<void> _fetchProjects() async {
    _projects = await _projectRepository.getAllProjectByCategoryId(category.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _projectListController.close();
  }
}
