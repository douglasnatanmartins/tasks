import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/model_contract.dart';

class TaskModel implements ModelContract {
  /// Constructor of a task model object.
  TaskModel({
    int id,
    @required String title,
    @required bool done,
    @required int projectId,
    String note,
    bool important,
    @required DateTime createdDate,
    DateTime dueDate
  }) {
    this._id = id;
    this._title = title;
    this._done = done ? 1 : 0;
    this._projectId = projectId;
    this._note = note;
    this._important = important ? 1 : 0;
    this._createdDate = createdDate;
    this._dueDate = dueDate;
  }

  /// Constructor of a task model object from a Map object.
  /// 
  /// The [data] argument must not be null.
  TaskModel.from(Map<String, dynamic> data) {
    this._id = data['id'];
    this._title = data['title'];
    this._done = data['done'];
    this._projectId = data['project_id'];
    this._note = data['note'];
    this._important = data['important'];
    this._createdDate = DateTime.parse(data['created_date']);
    this._dueDate = data['due_date'] != null ? DateTime.parse(data['due_date']) : null;
  }

  int _id;
  String _title;
  int _done;
  int _projectId;
  String _note;
  int _important;
  DateTime _createdDate;
  DateTime _dueDate;

  /// Get the task id.
  int get id => this._id;

  /// Get the task title.
  String get title => this._title;

  /// Get the complete task status.
  bool get done => this._done == 1 ? true : false;

  /// Get the project id of task.
  int get projectId => this._projectId;

  /// Get the project note.
  String get note => this._note;

  /// Get the important status of task.
  bool get important => this._important == 1 ? true : false;

  /// Get the created date of task.
  DateTime get createdDate => this._createdDate;

  /// Get the due date of task.
  DateTime get dueDate => this._dueDate;

  /// Set new task title.
  set title(String title) {
    this._title = title;
  }

  /// Set new completed status of task.
  set done(bool done) {
    this._done = done ? 1 : 0;
  }

  /// Set new the project id of task.
  set projectId(int id) {
    this._projectId = id;
  }

  /// Set new the task note.
  set note(String note) {
    this._note = note;
  }

  /// Set new the important status of task.
  set important(bool important) {
    this._important = important ? 1 : 0;
  }

  /// Set new the due date of task.
  set dueDate(DateTime date) {
    this._dueDate = date;
  }

  /// Returns a map object to representation of this model object.
  Map<String, dynamic> toMap() {
    var object = Map<String, dynamic>();
    object['id'] = this._id;
    object['title'] = this._title;
    object['done'] = this._done;
    object['project_id'] = this._projectId;
    object['note'] = this._note;
    object['important'] = this._important;
    object['created_date'] = this._createdDate.toString();
    object['due_date'] = this.dueDate != null ? DateFormat('yyyy-MM-dd').format(this._dueDate) : null;
    return object;
  }

  @override
  bool operator == (object) {
    return object is TaskModel
        && object.id == this.id
        && object.title == this.title
        && object.done == this.done
        && object.projectId == this.projectId
        && object.note == this.note
        && object.important == this.important
        && object.createdDate == this.createdDate
        && object.dueDate == this.dueDate;
  }

  @override
  int get hashCode {
    return this.id.hashCode ^
           this.title.hashCode ^
           this.done.hashCode ^
           this.projectId.hashCode ^
           this.note.hashCode ^
           this.important.hashCode ^
           this.createdDate.hashCode ^
           this.dueDate.hashCode;
  }
}
