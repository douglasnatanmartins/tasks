import '../entities/project_entity.dart';

abstract class ProjectRepositoryContract {
  Future<List<ProjectEntity>> getAll();
  Future<List<ProjectEntity>> getAllProjectByCategoryId(int categoryId);
  Future<ProjectEntity> getProjectById(int id);
  Future<bool> createProject(ProjectEntity data);
  Future<bool> updateProject(ProjectEntity data);
  Future<bool> deleteProject(ProjectEntity data);
}
