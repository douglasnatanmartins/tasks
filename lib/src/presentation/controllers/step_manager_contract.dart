import 'package:tasks/src/domain/entities/step_entity.dart';

abstract class StepManagerContract {
  Future<bool> addStep(StepEntity model);
  Future<bool> updateStep(StepEntity previous, StepEntity current);
  Future<bool> deleteStep(StepEntity model);
}
