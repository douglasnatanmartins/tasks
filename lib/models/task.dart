import 'package:tasks/models/step.dart';

class Task {
  Task({this.title});

  String title;
  bool _done = false;
  String _note;
  List<Step> _steps = [];

  String get note => _note;
  set note(String note) => _note = note;
  bool get done => _done;
  set done(bool done) => _done = done;

  List<Step> get steps => _steps;
  set steps(List<Step> steps) => _steps = steps;
}
