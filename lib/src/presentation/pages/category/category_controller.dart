import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/repositories/project_repository_contract.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_project_repository.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';

/// Category Page Business Logic Component.
class CategoryController extends Controller with ProjectManagerContract {
  /// Business Logic Component for the Category Page.
  CategoryController(this.category) {
    this._projectRepository = GetProjectRepository().getRepository();
    this._taskRepository = GetTaskRepository().getRepository();
    this._projectsController = StreamController<List<ProjectEntity>>.broadcast();

    // Initial
    this._fetchProjects().then((result) {
      this.pushProjects();
    });
  }

  // Stream of project in the category.
  StreamController<List<ProjectEntity>> _projectsController;
  Stream<List<ProjectEntity>> get projects => this._projectsController.stream;

  ProjectRepositoryContract _projectRepository;
  TaskRepositoryContract _taskRepository;

  final CategoryEntity category;
  List<ProjectEntity> _projects;

  /// Add new a project
  @override
  Future<bool> addProject(ProjectEntity entity) async {
    bool result = await this._projectRepository.createProject(entity);
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Delete a project.
  @override
  Future<bool> deleteProject(ProjectEntity project) async {
    bool result = await this._projectRepository.deleteProject(project);
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Update project object.
  @override
  Future<bool> updateProject(ProjectEntity previous, ProjectEntity current) async {
    bool result = await this._projectRepository.updateProject(current);
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Get progress completed of the project.
  Future<double> getProgressProject(int projectId) async {
    final data = await this._taskRepository.getAllTaskByProjectId(projectId);
    if (data != null && data.length > 0) {
      int total = data.length;
      int completed = 0;
      data.forEach((task) {
        if (task.isDone) completed++;
      });

      return completed / total;
    }
    return 0.0;
  }

  /// Refresh project list.
  Future<void> pushProjects() async {
    this._projectsController.add(this._projects);
  }

  Future<void> _fetchProjects() async {
    this._projects = await this._projectRepository.getAllProjectByCategoryId(this.category.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _projectsController.close();
  }
}
