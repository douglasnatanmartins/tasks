import 'dart:async';

class TaskListScreenBloc {
  StreamController _action = StreamController.broadcast();
  void dispose() {
    _action.close();
  }
}
