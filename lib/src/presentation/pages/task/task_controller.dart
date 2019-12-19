import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/usecases/get_step_repository.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';

/// The Business Logic Component for the Task Page.
class TaskController implements Controller, StepManagerContract {
  /// Constructor of Business Logic Component for the Task Page.
  /// 
  /// The [task] argument must not be null.
  TaskController(this.task) {
    _fetchSteps().then((result) {
      pushSteps();
    });
  }

  final _stepRepository = GetStepRepository().getRepository();
  final _stepListController = StreamController<List<StepEntity>>.broadcast();
  Stream<List<StepEntity>> get steps => _stepListController.stream;

  TaskEntity task;
  List<StepEntity> _steps = <StepEntity>[];

  /// Add a step to task object.
  @override
  Future<bool> createStep(StepEntity data) async {
    bool result = await _stepRepository.createStep(data);
    if (result) {
      await _fetchSteps();
      pushSteps();
    }

    return result;
  }

  /// Delete the step object from task object.
  @override
  Future<bool> deleteStep(StepEntity data) async {
    bool result = await _stepRepository.deleteStep(data);
    if (result) {
      bool completed = _steps.remove(data);
      if (completed) {
        pushSteps();
      }
    }

    return result;
  }

  /// Update the step object on task object.
  @override
  Future<bool> updateStep(StepEntity current, StepEntity previous) async {
    bool result = await _stepRepository.updateStep(current);
    if (result) {
      int index = _steps.indexOf(previous);
      _steps[index] = current;
      pushSteps();
    }

    return result;
  }

  /// Refresh step list in the task.
  Future<void> pushSteps() async {
    _stepListController.add(_steps);
  }

  /// Fetch all steps of task.
  Future<void> _fetchSteps() async {
    _steps = await _stepRepository.getAllStepByTaskId(task.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _stepListController.close();
  }
}
