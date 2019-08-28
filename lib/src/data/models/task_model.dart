import 'package:flutter/foundation.dart';
import 'package:tasks/src/data/models/step_model.dart';

class TaskModel {
  String _title;
  String _note;
  bool _finished;
  List<StepModel> _steps;

  String get title => _title;
  set title(String title) => _title = title;

  String get note => _note;
  set note(String note) => _note = note;

  bool get finished => _finished;
  set finished(bool finished) => _finished = finished;

  List<StepModel> get allSteps => _steps;
  set allSteps(List<StepModel> steps) => _steps = steps;

  TaskModel({@required String title, bool finished = false, String note = "", List<StepModel> steps}) {
    _title = title;
    _finished = finished;
    _note = "";
    _steps = steps != null ? steps : [];
  }
}
