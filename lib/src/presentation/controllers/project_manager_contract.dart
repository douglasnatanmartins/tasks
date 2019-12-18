import 'package:tasks/src/domain/entities/project_entity.dart';

abstract class ProjectManagerContract {
  /// Create new project.
  /// 
  /// The [data] argument must not be null.
  Future<bool> createProject(ProjectEntity data);

  /// Delete the project.
  /// 
  /// The [data] argument must not be null.
  Future<bool> deleteProject(ProjectEntity data);

  /// Update the project.
  /// 
  /// The [current] and [previous] arguments must not be null.
  Future<bool> updateProject(ProjectEntity current, ProjectEntity previous);
}
