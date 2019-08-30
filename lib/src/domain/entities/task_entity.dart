import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';

class TaskEntity {
  String _title;
  bool _done;
  List<StepEntity> _steps;

  String get title => _title;
  set title(String title) => _title = title;

  bool get done => _done;
  set done(bool done) => _done = done;

  List<StepEntity> get steps => _steps;
  set steps(List<StepEntity> steps) => _steps = steps;

  TaskEntity({
    @required String title,
    bool done = false
  }) {
    _title = title;
    _done = done;
    _steps = [];
  }
}
