import 'package:tasks/src/core/contracts/usecase.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

import '../repositories/task_repository_contract.dart';

class GetTaskRepository implements UseCase {
  TaskRepositoryContract getRepository() {
    return TaskRepository();
  }
}
