import '../entities/step_entity.dart';

abstract class StepRepositoryContract {
  Future<List<StepEntity>> getAll();
  Future<List<StepEntity>> getAllStepByTaskId(int taskId);
  Future<StepEntity> getStepById(int id);
  Future<bool> createStep(StepEntity data);
  Future<bool> updateStep(StepEntity data);
  Future<bool> deleteStep(StepEntity data);
}
