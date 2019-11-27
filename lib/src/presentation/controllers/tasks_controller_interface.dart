import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/data/models/task_model.dart';

abstract class TasksControllerInterface implements Controller {
  Future<bool> addTask(TaskModel model);
  Future<bool> updateTask(TaskModel model);
  Future<bool> deleteTask(TaskModel model);
}
