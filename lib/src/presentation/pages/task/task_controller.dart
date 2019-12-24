import 'dart:async';
import 'package:meta/meta.dart';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/usecases/get_step_repository.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

/// The Business Logic Component for the Task Page.
class TaskController implements Controller, StepManagerContract {
  /// Constructor of Business Logic Component for the Task Page.
  /// 
  /// The [task] argument must not be null.
  TaskController({
    @required TaskEntity task,
    @required TaskManagerContract manager,
  }): assert(task != null),
      assert(manager != null),
      _taskInitial = task,
      _task = task,
      _taskManager = manager {
    _fetchSteps().then((result) {
      _pushStepList();
    });
  }

  final TaskManagerContract _taskManager;
  final _stepRepository = GetStepRepository().getRepository();

  final _stepListSubject = StreamController<List<StepEntity>>.broadcast();
  Stream<List<StepEntity>> get stepListStream => _stepListSubject.stream;

  final TaskEntity _taskInitial;
  TaskEntity _task;
  TaskEntity get task => _task;

  List<StepEntity> _steps = <StepEntity>[];
  List<StepEntity> get steps => _steps;

  void setTaskTitle(String title) {
    _task = _task.copyWith(title: title);
  }

  void setTaskNote(String note) {
    _task = _task.copyWith(note: note);
  }

  void setTaskDueDate(DateTime date) {
    _task = _task.copyWith(dueDate: date);
  }

  void setTaskIsDone(bool checked) {
    _task = _task.copyWith(isDone: checked);
  }

  void setTaskIsImportant(bool checked) {
    _task = _task.copyWith(isImportant: checked);
  }

  Future<bool> deleteTask() {
    return _taskManager.deleteTask(_task);
  }

  Future<bool> updateTask() async {
    bool result = false;
    if (_taskInitial != _task) {
      result = await _taskManager.updateTask(_task, _taskInitial);
    }

    return result;
  }

  /// Add a step to task object.
  @override
  Future<bool> createStep(StepEntity data) async {
    bool result = await _stepRepository.createStep(data);
    if (result) {
      await _fetchSteps();
      _pushStepList();
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
        _pushStepList();
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
      _pushStepList();
    }

    return result;
  }

  /// Fetch all steps of task.
  Future<void> _fetchSteps() async {
    _steps = await _stepRepository.getAllStepByTaskId(task.id);
  }

  void _pushStepList() {
    _stepListSubject.add(_steps);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _stepListSubject.close();
  }
}
