import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class TaskEntity implements Entity<TaskEntity> {
  /// Create a task entity.
  /// 
  /// The [projectId] and [title] arguments must not be null.
  TaskEntity({
    @required this.id,
    @required this.projectId,
    @required this.title,
    @required this.note,
    @required this.isDone,
    @required this.isImportant,
    @required this.dueDate,
    @required this.createdDate,
  }): assert(projectId != null),
      assert(title != null);

  final int id;
  final int projectId;
  final bool isDone;
  final bool isImportant;
  final String title;
  final String note;
  final DateTime dueDate;
  final DateTime createdDate;

  @override
  TaskEntity copyWith({
    int projectId,
    String title,
    String note,
    bool isDone,
    bool isImportant,
    DateTime dueDate,
  }) {
    return TaskEntity(
      id: this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
      isImportant: isImportant ?? this.isImportant,
      dueDate: dueDate ?? this.dueDate,
      createdDate: this.createdDate,
    );
  }

  @override
  String toString() {
    return '[Task ${this.id}]: title: ${this.title}, isDone: ${this.isDone}, isImportant: ${this.isImportant}';
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is TaskEntity
        && object.id == this.id
        && object.projectId == this.projectId
        && object.title == this.title
        && object.note == this.note
        && object.isDone == this.isDone
        && object.isImportant == this.isImportant
        && object.dueDate == this.dueDate
        && object.createdDate == this.createdDate;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.projectId.hashCode
         ^ this.title.hashCode
         ^ this.note.hashCode
         ^ this.isDone.hashCode
         ^ this.isImportant.hashCode
         ^ this.dueDate.hashCode
         ^ this.createdDate.hashCode;
  }
}
