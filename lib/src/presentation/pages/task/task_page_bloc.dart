import 'dart:async';
import 'package:meta/meta.dart';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/step_repository.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

/// Task Page Business Logic Component
class TaskPageBloc implements BlocContract {
  // Stream of step list.
  final _controllerSteps = StreamController();
  Sink get sinkSteps => _controllerSteps.sink;
  Stream get streamSteps => _controllerSteps.stream;

  TaskRepository _taskRepository;
  StepRepository _stepRepository;

  TaskModel _task;

  TaskPageBloc(TaskModel task) {
    this._task = task;
    this._taskRepository = TaskRepository();
    this._stepRepository = StepRepository();
  }

  /// Update the task.
  void updateTask(TaskModel task) {
    this._taskRepository.update(task.toMap());
  }

  Future<void> deleteTask(TaskModel task) async {
    await _taskRepository.delete(task.id);
  }

  /// Add a step into task.
  void addStep(StepModel step) {
    this._stepRepository.add(step.toMap()).then((_) {
      this.refreshSteps();
    });
  }

  /// Update a step.
  void updateStep(StepModel step) {
    this._stepRepository.update(step.toMap()).then((_) {
      this.refreshSteps();
    });
  }

  /// Delete a step.
  void deleteStep(StepModel step) {
    this._stepRepository.delete(step.id).then((_) {
      this.refreshSteps();
    });
  }

  /// Refresh step list in the task.
  void refreshSteps() {
    this._stepRepository.getStepsByTaskId(this._task.id).then((steps) {
      List<StepModel> data = [];
      steps.forEach((step) {
        data.add(StepModel.from(step));
      });

      this.sinkSteps.add(data);
    });
  }

  @override
  void dispose() {
    this._controllerSteps.close();
  }
}
