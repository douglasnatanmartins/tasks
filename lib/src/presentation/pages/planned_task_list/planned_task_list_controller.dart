import 'dart:async';
import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';
import 'package:tasks/src/utils/date_time_util.dart';

/// Home Page Business Logic Component.
class PlannedTaskListController extends Controller with TaskManagerContract {
  PlannedTaskListController() {
    _fetchTasks().then((_) => pushTasks());
  }

  final _taskRepository = GetTaskRepository().getRepository();
  final _taskListController = StreamController<Map<DateTime, List<TaskEntity>>>.broadcast();
  Stream<Map<DateTime, List<TaskEntity>>> get tasks => _taskListController.stream;

  List<TaskEntity> _tasks = <TaskEntity>[];

  @override
  Future<bool> createTask(TaskEntity data) {
    return null;
  }

  @override
  Future<bool> deleteTask(TaskEntity data) async {
    var result = await _taskRepository.deleteTask(data);
    if (result) {
      _tasks.remove(data);
      pushTasks();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity current, TaskEntity previous) async {
    var result = await _taskRepository.updateTask(current);

    if (result) {
      int index = _tasks.indexOf(previous);
      _tasks[index] = current;
      pushTasks();
    }

    return result;
  }

  Future<void> pushTasks() async {
    var items = <DateTime, List<TaskEntity>>{};

    for (var item in _tasks) {
      DateTime dueDate = DateTimeUtil.onlyDate(item.dueDate);
      if (!items.containsKey(dueDate)) {
        items[dueDate] = List<TaskEntity>();
      }
      items[dueDate].add(item);
    }

    _taskListController.add(items);
  }

  Future<void> _fetchTasks() async {
    _tasks = await _taskRepository.getAllDueDateTask();
  }

  /// Dispose business logic component.
  @override
  void dispose() {
    _taskListController.close();
  }
}
