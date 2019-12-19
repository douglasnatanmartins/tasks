import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class TaskEntity implements Entity<TaskEntity> {
  /// Create a task entity.
  /// 
  /// The [projectId] and [title], [isDone], [isImportant], [createdDate]
  /// arguments must not be null.
  TaskEntity({
    this.id,
    @required this.projectId,
    @required this.title,
    @required this.isDone,
    @required this.isImportant,
    @required this.createdDate,
    this.dueDate,
    this.note,
  }): assert(projectId != null),
      assert(title != null),
      assert(isDone != null),
      assert(isImportant != null),
      assert(createdDate != null);

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
      id: id,
      projectId: projectId ?? projectId,
      title: title ?? title,
      note: note ?? note,
      isDone: isDone ?? isDone,
      isImportant: isImportant ?? isImportant,
      dueDate: dueDate ?? dueDate,
      createdDate: createdDate,
    );
  }

  @override
  String toString() {
    return '[Task $id]: '
    'title: $title, '
    'isDone: $isDone, '
    'isImportant: $isImportant, '
    'dueDate: $dueDate';
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is TaskEntity
        && object.id == id
        && object.projectId == projectId
        && object.title == title
        && object.note == note
        && object.isDone == isDone
        && object.isImportant == isImportant
        && object.dueDate == dueDate
        && object.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode
         ^ projectId.hashCode
         ^ title.hashCode
         ^ note.hashCode
         ^ isDone.hashCode
         ^ isImportant.hashCode
         ^ dueDate.hashCode
         ^ createdDate.hashCode;
  }
}
