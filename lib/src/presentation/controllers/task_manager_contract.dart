import 'package:tasks/src/domain/entities/task_entity.dart';

abstract class TaskManagerContract {
  Future<bool> addTask(TaskEntity entity);
  Future<bool> updateTask(TaskEntity previous, TaskEntity current);
  Future<bool> deleteTask(TaskEntity entity);
}
