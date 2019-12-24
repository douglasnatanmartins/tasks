import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/usecases/get_task_repository.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';

/// The Business Logic Component for the Project Page.
class ProjectController implements Controller, TaskManagerContract {
  /// Constructor of Business Logic Component for the Project Page.
  /// 
  /// The [project] argument must not be null.
  ProjectController({
    ProjectEntity project,
    ProjectManagerContract manager,
  }): assert(project != null),
      assert(manager != null),
      _project = project,
      _projectManager = manager {
    _fetchTasks().then((_) => _pushTaskList());
  }

  final ProjectManagerContract _projectManager;

  final _taskRepository = GetTaskRepository().getRepository();

  final _projectSubject = StreamController<ProjectEntity>();
  Stream<ProjectEntity> get projectStream => _projectSubject.stream;

  final _taskListSubject = StreamController<List<TaskEntity>>.broadcast();
  Stream<List<TaskEntity>> get taskListStream => _taskListSubject.stream;

  ProjectEntity _project;
  ProjectEntity get project => _project;
  List<TaskEntity> _tasks = <TaskEntity>[];

  Future<bool> deleteProject() {
    return _projectManager.deleteProject(_project);
  }

  Future<bool> updateProject(ProjectEntity newProject) async {
    bool result = false;
    if (newProject != _project) {
      result = await _projectManager.updateProject(newProject, _project);
      if (result) {
        _project = newProject;
        _pushProject();
      }
    }

    return result;
  }

  @override
  Future<bool> createTask(TaskEntity data) async {
    bool result = await _taskRepository.createTask(data);
    if (result) {
      await _fetchTasks();
      _pushTaskList();
    }

    return result;
  }

  @override
  Future<bool> deleteTask(TaskEntity data) async {
    bool result = await _taskRepository.deleteTask(data);
    if (result) {
      _tasks.remove(data);
      _pushTaskList();
    }

    return result;
  }

  @override
  Future<bool> updateTask(TaskEntity current, TaskEntity previous) async {
    bool result = await _taskRepository.updateTask(current);

    if (result) {
      int index = _tasks.indexOf(previous);
      _tasks[index] = current;
      _pushTaskList();
    }

    return result;
  }

  void _pushProject() {
    _projectSubject.add(_project);
  }

  void _pushTaskList() {
    _taskListSubject.add(_tasks);
  }

  /// Fetch all task from database.
  Future<void> _fetchTasks() async {
    _tasks = await _taskRepository.getAllTaskByProjectId(project.id);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    _projectSubject.close();
    _taskListSubject.close();
  }
}
