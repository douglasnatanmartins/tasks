import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/step_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_step_repository.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';

/// Task Page Business Logic Component
class TaskController extends Controller with StepManagerContract {
  /// Create a Task Page Business Logic Component.
  /// 
  /// The [data] argument must not be null.
  TaskController(this.task) {
    this._stepRepository = GetStepRepository().getRepository();
    this._stepsController = StreamController<List<StepEntity>>.broadcast();

    // Initial
    this._fetchSteps().then((result) {
      this.pushSteps();
    });
  }

  StepRepositoryContract _stepRepository;

  // Stream of step list.
  StreamController<List<StepEntity>> _stepsController;
  Stream<List<StepEntity>> get steps => this._stepsController.stream;

  TaskEntity task;
  List<StepEntity> _steps = <StepEntity>[];

  /// Add a step to task object.
  @override
  Future<bool> addStep(StepEntity entity) async {
    bool result = await this._stepRepository.createStep(entity);
    if (result) {
      await this._fetchSteps();
      this.pushSteps();
    }
    return result;
  }

  /// Delete the step object from task object.
  @override
  Future<bool> deleteStep(StepEntity entity) async {
    bool result = await this._stepRepository.deleteStep(entity);
    if (result) {
      bool completed = this._steps.remove(entity);
      if (completed) {
        this.pushSteps();
      }
    }
    return result;
  }

  /// Update the step object on task object.
  @override
  Future<bool> updateStep(StepEntity previous, StepEntity current) async {
    bool result = await this._stepRepository.updateStep(current);
    if (result) {
      int index = this._steps.indexOf(previous);
      this._steps[index] = current;
      this.pushSteps();
    }
    return result;
  }

  /// Refresh step list in the task.
  Future<void> pushSteps() async {
    this._stepsController.add(this._steps);
  }

  /// Fetch all steps of task.
  Future<void> _fetchSteps() async {
    this._steps = await this._stepRepository.getAllStepByTaskId(this.task.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _stepsController.close();
  }
}
