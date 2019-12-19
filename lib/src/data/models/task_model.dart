import 'package:meta/meta.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int id,
    @required int projectId,
    @required String title,
    @required bool isDone,
    @required bool isImportant,
    @required DateTime createdDate,
    String note,
    DateTime dueDate,
  }): super(
    id: id,
    projectId: projectId,
    title: title,
    note: note,
    isDone: isDone,
    isImportant: isImportant,
    dueDate: dueDate,
    createdDate: createdDate,
  );

  factory TaskModel.from(Map<String, dynamic> object) {
    return TaskModel(
      id: object['id'],
      projectId: object['project_id'],
      title: object['title'],
      note: object['note'],
      isDone: object['is_done'] == 1 ? true : false,
      isImportant: object['is_important'] == 1 ? true : false,
      dueDate: object['due_date'] != null ? DateTime.parse(object['due_date']) : null,
      createdDate: DateTime.parse(object['created_date']),
    );
  }
}
