import 'package:tasks/src/core/contracts/usecase.dart';
import 'package:tasks/src/data/repositories/step_repository.dart';
import '../repositories/step_repository_contract.dart';

class GetStepRepository implements UseCase {
  StepRepositoryContract getRepository() {
    return StepRepository();
  }
}
