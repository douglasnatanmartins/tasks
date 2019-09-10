import 'package:tasks/src/data/contracts/model_contract.dart';

class StepModel implements ModelContract {
  int _id;
  String _title;
  int _done;
  int _taskId;

  int get id => this._id;

  String get title => this._title;
  set title(String title) {
    this._title = title;
  }

  bool get done => this._done == 1 ? true : false;
  set done(bool done) {
    this._done = done ? 1 : 0;
  }

  int get taskId => this._taskId;
  set taskId(int id) {
    this._taskId = id;
  }

  /// Constructor of a step model object.
  StepModel({int id, String title, bool done, int taskId}) {
    this._id = id;
    this._title = title;
    this._done = done ? 1 : 0;
    this._taskId = taskId;
  }

  /// Constructor of a task model object from a Map object.
  StepModel.from(Map<String, dynamic> object) {
    this._id = object['id'];
    this._title = object['title'];
    this._done = object['done'];
    this._taskId = object['taskId'];
  }

  /// Returns a map object to representation of this object.
  @override
  Map<String, dynamic> toMap() {
    var object = Map<String, dynamic>();
    object['id'] = this._id;
    object['title'] = this._title;
    object['done'] = this._done;
    object['taskId'] = this._taskId;
    return object;
  }
}
