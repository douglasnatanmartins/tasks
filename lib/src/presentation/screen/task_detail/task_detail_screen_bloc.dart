import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

class TaskDetailScreenBloc {
  final _controllerOfTask = StreamController.broadcast();
  Sink get sinkOfTask => _controllerOfTask.sink;
  Stream get streamOfTask => _controllerOfTask.stream;
  final _controllerOfSteps = StreamController.broadcast();
  Sink get sinkOfSteps => _controllerOfSteps.sink;
  Stream get streamOfSteps => _controllerOfSteps.stream;

  TaskEntity _task;

  TaskDetailScreenBloc({@required TaskEntity task}) {
    _task = task;
  }

  void addStep(StepEntity step) {
    _task.steps.add(step);
    _sinkingSteps();
  }

  void updateStep(int index, StepEntity step) {
    _task.steps.removeAt(index);
    _task.steps.insert(index, step);
  }

  void markStepIsDone(int index, bool isDone) {
    _task.steps[index].done = isDone;
    _sinkingSteps();
  }

  void _sinkingTask() => sinkOfTask.add(_task);
  void _sinkingSteps() => sinkOfSteps.add(_task.steps);

  void dispose() {
    _controllerOfSteps.close();
    _controllerOfTask.close();
  }
}
