import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/data/models/project_model.dart';

abstract class ProjectsControllerInterface implements Controller {
  Future<bool> addProject(ProjectModel model);
  Future<bool> updateProject(ProjectModel previous, ProjectModel current);
  Future<bool> deleteProject(ProjectModel model);
}
