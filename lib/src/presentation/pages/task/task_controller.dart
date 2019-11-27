import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/step_repository.dart';

/// Task Page Business Logic Component
class TaskController implements Controller {
  /// Create a Task Page Business Logic Component.
  /// 
  /// The [data] argument must not be null.
  TaskController(TaskModel data) {
    this.data = data;
    this._fetchSteps().then((result) {
      this.pushSteps();
    });
  }

  final StepRepository _stepRepository = StepRepository();
  TaskModel data;
  List<StepModel> _steps = <StepModel>[];

  // Stream of step list.
  final _stepsController = StreamController<List<StepModel>>();
  Stream<List<StepModel>> get steps => this._stepsController.stream;

  /// Add a step into task.
  Future<bool> addStep(StepModel model) async {
    bool result = await this._stepRepository.add(model.toMap());
    if (result) {
      await this._fetchSteps();
      this.pushSteps();
    }
    return result;
  }

  /// Update a step.
  Future<bool> updateStep(StepModel oldModel, StepModel newModel) async {
    bool result = await this._stepRepository.update(newModel.toMap());
    if (result) {
      int index = this._steps.indexOf(oldModel);
      this._steps[index] = newModel;
      this.pushSteps();
    }
    return result;
  }

  /// Delete a step.
  Future<bool> deleteStep(StepModel model) async {
    bool result = await this._stepRepository.delete(model.id);
    if (result) {
      bool completed = this._steps.remove(model);
      if (completed) {
        this.pushSteps();
      }
    }
    return result;
  }

  /// Refresh step list in the task.
  Future<void> pushSteps() async {
    this._stepsController.add(this._steps);
  }

  /// Fetch all steps of task.
  Future<void> _fetchSteps() async {
    final data = await this._stepRepository.getStepsByTaskId(this.data.id);
    this._steps = data.map((Map<String, dynamic> item) {
      return StepModel.from(item);
    }).toList();
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _stepsController.close();
  }
}
