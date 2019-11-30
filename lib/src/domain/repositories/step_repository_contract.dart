import '../entities/step_entity.dart';

abstract class StepRepositoryContract {
  Future<List<StepEntity>> getAll();
  Future<List<StepEntity>> getAllStepByTaskId(int taskId);
  Future<StepEntity> getStepById(int id);
  Future<bool> createStep(StepEntity entity);
  Future<bool> updateStep(StepEntity entity);
  Future<bool> deleteStep(StepEntity entity);
}
