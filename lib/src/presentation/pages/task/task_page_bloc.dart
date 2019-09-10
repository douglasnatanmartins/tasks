import 'dart:async';
import 'package:meta/meta.dart';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/data/repositories/step_repository.dart';

class TaskPageBloc implements BlocContract {
  final _controllerSteps = StreamController();
  Sink get sinkSteps => _controllerSteps.sink;
  Stream get streamSteps => _controllerSteps.stream;
  StepRepository _stepRepository;

  TaskModel _task;

  TaskPageBloc({@required TaskModel task}) {
    _task = task;
    _stepRepository = StepRepository();
    refreshSteps();
  }

  void addStep(StepModel step) {
    _stepRepository.add(step.toMap()).then((_) {
      refreshSteps();
    });
  }

  void updateStep(StepModel step) {
    _stepRepository.update(step.toMap()).then((_) {
      refreshSteps();
    });
  }

  void deleteStep(StepModel step) {
    _stepRepository.delete(step.id).then((_) {
      refreshSteps();
    });
  }

  void refreshSteps() {
    _stepRepository.getStepsByTaskId(this._task.id).then((steps) {
      List<StepModel> data = [];
      steps.forEach((step) {
        data.add(StepModel.from(step));
      });

      sinkSteps.add(data);
    });
  }

  @override
  void dispose() {
    _controllerSteps.close();
  }
}
