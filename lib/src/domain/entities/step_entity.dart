import 'package:flutter/foundation.dart';

class StepEntity {
  String _title;
  bool _done;

  String get title => _title;
  set title(String title) => _title = title;

  bool get done => _done;
  set done(bool done) => _done = done;

  StepEntity({
    @required String title,
    bool done = false
  }) {
    _title = title;
    _done = done;
  }
}
