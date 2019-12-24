import 'package:tasks/src/domain/entities/step_entity.dart';

abstract class StepManagerContract {
  /// Create new step.
  /// 
  /// The [data] argument must not be null.
  Future<bool> createStep(StepEntity data);

  /// Delete the step.
  /// 
  /// The [data] argument must not be null.
  Future<bool> deleteStep(StepEntity data);

  /// Update the step.
  /// 
  /// The [current] and [previous] arguments must not be null.
  Future<bool> updateStep(StepEntity current, StepEntity previous);
}
