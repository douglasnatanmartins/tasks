import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/model_contract.dart';

class StepModel implements ModelContract {
  /// Constructor of a step model object.
  StepModel({
    int id,
    @required String title,
    @required bool done,
    @required int taskId,
  }) {
    this._id = id;
    this._title = title;
    this._done = done ? 1 : 0;
    this._taskId = taskId;
  }

  /// Constructor of a task model object from a Map object.
  /// 
  /// The [data] argument must not be null.
  StepModel.from(Map<String, dynamic> data) {
    this._id = data['id'];
    this._title = data['title'];
    this._done = data['done'];
    this._taskId = data['task_id'];
  }

  int _id;
  String _title;
  int _done;
  int _taskId;

  /// Get the step id.
  int get id => this._id;

  /// Get the step title.
  String get title => this._title;

  /// Get the step complete status.
  bool get done => this._done == 1 ? true : false;

  /// Get the task id of step.
  int get taskId => this._taskId;

  /// Set new the step title.
  set title(String title) {
    this._title = title;
  }

  /// Set new the step complete status.
  set done(bool done) {
    this._done = done ? 1 : 0;
  }

  /// Set new the task id of step.
  set taskId(int id) {
    this._taskId = id;
  }

  /// Returns a map object to representation of this model object.
  @override
  Map<String, dynamic> toMap() {
    var object = Map<String, dynamic>();
    object['id'] = this._id;
    object['title'] = this._title;
    object['done'] = this._done;
    object['task_id'] = this._taskId;
    return object;
  }

  @override
  bool operator == (object) {
    return object is StepModel
        && object.id == this.id
        && object.title == this.title
        && object.done == this.done
        && object.taskId == this.taskId;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.title.hashCode
         ^ this.done.hashCode
         ^ this.taskId.hashCode;
  }
}
