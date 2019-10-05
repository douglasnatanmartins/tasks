import 'dart:async';

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

  TaskRepository taskRepository;
  StepRepository stepRepository;

  TaskModel task;

  TaskPageBloc(TaskModel task) {
    this.task = task;
    this.taskRepository = TaskRepository();
    this.stepRepository = StepRepository();
  }

  /// Update the task.
  Future<bool> updateTask(TaskModel task) async {
    bool result = await this.taskRepository.update(task.toMap());
    return result;
  }

  /// Delete the task.
  Future<bool> deleteTask(TaskModel task) async {
    return await this.taskRepository.delete(task.id);
  }

  /// Add a step into task.
  Future<bool> addStep(StepModel step) async {
    bool result = await this.stepRepository.add(step.toMap());
    if (result) {
      this.refreshSteps();
    }
    return result;
  }

  /// Update a step.
  Future<bool> updateStep(StepModel step) async {
    bool result = await this.stepRepository.update(step.toMap());
    if (result) {
      this.refreshSteps();
    }
    return result;
  }

  /// Delete a step.
  Future<bool> deleteStep(StepModel step) async {
    bool result = await this.stepRepository.delete(step.id);
    if (result) {
      this.refreshSteps();
    }
    return result;
  }

  /// Refresh step list in the task.
  Future<void> refreshSteps() async {
    final data = await this.stepRepository.getStepsByTaskId(this.task.id);
    List<StepModel> steps = [];
    data.forEach((Map<String, dynamic> task) {
      steps.add(StepModel.from(task));
    });
    this.sinkSteps.add(steps);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _controllerSteps.close();
  }
}
