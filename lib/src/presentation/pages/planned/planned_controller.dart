import 'dart:async';
import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';
import 'package:tasks/src/utils/date_time_util.dart';

/// Home Page Business Logic Component.
class PlannedController extends Controller with TaskManagerContract {
  PlannedController() {
    this._taskRepository = GetTaskRepository().getRepository();
    this._tasksController = StreamController<Map<DateTime, List<TaskEntity>>>.broadcast();
    this._fetchTasks().then((result) {
      this.pushTasks();
    });
  }

  TaskRepositoryContract _taskRepository;

  StreamController<Map<DateTime, List<TaskEntity>>> _tasksController;
  Stream<Map<DateTime, List<TaskEntity>>> get tasks => this._tasksController.stream;
  Map<DateTime, List<TaskEntity>> _tasks = Map<DateTime, List<TaskEntity>>();

  @override
  Future<bool> addTask(TaskEntity entity) {
    return null;
  }

  @override
  Future<bool> deleteTask(TaskEntity entity) async {
    final result = await this._taskRepository.deleteTask(entity);
    if (result) {
      await this._fetchTasks();
      this.pushTasks();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity previous, TaskEntity current) async {
    final result = await this._taskRepository.updateTask(current);

    if (result) {
      await this._fetchTasks();
      this.pushTasks();
    }

    return result;
  }

  Future<void> pushTasks() async {
    this._tasksController.add(this._tasks);
  }

  Future<void> _fetchTasks() async {
    final data = await this._taskRepository.getAllDueDateTask();

    if (data == null) {
      this._tasks = Map<DateTime, List<TaskEntity>>();
      return;
    }

    final Map<DateTime, List<TaskEntity>> tasks = <DateTime, List<TaskEntity>>{};

    for (var item in data) {
      DateTime dueDate = DateTimeUtil.onlyDate(item.dueDate);
      if (!tasks.containsKey(dueDate)) {
        tasks[dueDate] = List<TaskEntity>();
      }
      tasks[dueDate].add(item);
    }

    this._tasks = tasks;
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    _tasksController.close();
  }
}
