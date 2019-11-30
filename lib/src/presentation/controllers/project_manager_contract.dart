import 'package:tasks/src/domain/entities/project_entity.dart';

abstract class ProjectManagerContract {
  Future<bool> addProject(ProjectEntity entity);
  Future<bool> updateProject(ProjectEntity previous, ProjectEntity current);
  Future<bool> deleteProject(ProjectEntity entity);
}
