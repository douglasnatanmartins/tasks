import 'dart:async';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';
import 'package:tasks/src/presentation/controllers/projects_controller_interface.dart';

/// Category Page Business Logic Component.
class CategoryController implements ProjectsControllerInterface {
  /// Business Logic Component for the Category Page.
  CategoryController(CategoryModel category) {
    this.category = category;
    this._fetchProjects().then((result) {
      this.pushProjects();
    });
  }

  // Stream of project in the category.
  final _projectsController = StreamController<List<Map<String, dynamic>>>();
  Stream get projects => this._projectsController.stream;

  final ProjectRepository _projectRepository = ProjectRepository();
  TaskRepository _taskRepository = TaskRepository();
  CategoryModel category;
  List<Map<String, dynamic>> _projects = <Map<String, dynamic>>[];

  /// Add new a project
  @override
  Future<bool> addProject(ProjectModel project) async {
    bool result = await this._projectRepository.add(project.toMap());
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Delete a project.
  @override
  Future<bool> deleteProject(ProjectModel project) async {
    bool result = await this._projectRepository.delete(project.id);
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Update project object.
  @override
  Future<bool> updateProject(ProjectModel previous, ProjectModel current) async {
    bool result = await this._projectRepository.update(current.toMap());
    if (result) {
      await this._fetchProjects();
      this.pushProjects();
    }
    return result;
  }

  /// Get progress completed of the project.
  Future<double> getProgressProject(int projectId) async {
    final data = await this._taskRepository.getTasksByProjectId(projectId);
    int total = data.length;

    // Fixes NaN.
    if (total == 0) return 0;

    int completed = 0;
    data.forEach((task) {
      if (task['done'] == 1) completed++;
    });

    return completed / total;
  }

  /// Refresh project list.
  Future<void> pushProjects() async {
    this._projectsController.add(this._projects);
  }

  Future<void> _fetchProjects() async {
    final data = await this._projectRepository.getProjectsByCategoryId(this.category.id);
    List<Map<String, dynamic>> items = <Map<String, dynamic>>[];
    for (var item in data) {
      final model = ProjectModel.from(item);
      final progress = await this.getProgressProject(model.id);
      items.add({
        'project': model,
        'progress': progress,
      });
    }
    this._projects = items;
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _projectsController.close();
  }
}
