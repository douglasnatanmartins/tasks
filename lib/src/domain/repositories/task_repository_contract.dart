import '../entities/task_entity.dart';

abstract class TaskRepositoryContract {
  Future<List<TaskEntity>> getAll();
  Future<List<TaskEntity>> getAllDueDateTask();
  Future<List<TaskEntity>> getAllImportantTask();
  Future<List<TaskEntity>> getAllTaskByProjectId(int projectId);
  Future<TaskEntity> getTaskById(int id);
  Future<bool> createTask(TaskEntity entity);
  Future<bool> updateTask(TaskEntity entity);
  Future<bool> deleteTask(TaskEntity entity);
}
