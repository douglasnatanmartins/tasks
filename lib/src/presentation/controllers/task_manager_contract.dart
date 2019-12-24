import 'package:tasks/src/domain/entities/task_entity.dart';

abstract class TaskManagerContract {
  /// Create new task.
  /// 
  /// The [data] argument must not be null.
  Future<bool> createTask(TaskEntity data);

  /// Delete the task.
  /// 
  /// The [data] argument must not be null.
  Future<bool> deleteTask(TaskEntity data);

  /// Update the task.
  /// 
  /// The [current] and [previous] arguments must not be null.
  Future<bool> updateTask(TaskEntity current, TaskEntity previous);
}
