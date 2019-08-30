import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';

class CategoryEntity {
  String _title;
  String _description;
  List<ProjectEntity> _projects;

  String get title => _title;
  set title(String title) => _title = title;

  String get description => _description;
  set description(String description) => _description = description;

  List<ProjectEntity> get projects => _projects;
  set projects(List<ProjectEntity> projects) => _projects = projects;

  CategoryEntity({
    @required String title,
    String description = ''
  }) {
    _title = title;
    _description = description;
    _projects = [];
  }

  bool hasProject(int index) {
    return _projects[index] != null;
  }

  ProjectEntity addProject(ProjectEntity project) {
    _projects.add(project);
    return project;
  }

  bool removeProject(ProjectEntity project) {
    return _projects.remove(project);
  }
}
