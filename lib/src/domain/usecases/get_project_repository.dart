import 'package:tasks/src/core/contracts/usecase.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';

import '../repositories/project_repository_contract.dart';

class GetProjectRepository implements UseCase {
  ProjectRepositoryContract getRepository() {
    return ProjectRepository();
  }
}
