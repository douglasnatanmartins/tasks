import 'dart:async';

import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';

class TaskRepository implements TaskRepositoryContract {
  @override
  Future<List<TaskEntity>> getAll() async {
    var db = await LocalSource().database;
    var data = await db.query('Task');

    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllDueDateTask() async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Task',
      where: 'due_date IS NOT NULL',
      orderBy: 'due_date ASC',
    );

    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllImportantTask() async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Task',
      where: 'is_important = 1',
      orderBy: 'due_date ASC',
    );

    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllTaskByProjectId(int projectId) async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Task',
      where: 'project_id = ?',
      whereArgs: [projectId],
    );

    return _convertToEntities(data);
  }

  @override
  Future<TaskEntity> getTaskById(int id) async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Task',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (data != null) {
      return TaskModel.from(data.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createTask(TaskEntity data) async {
    var db = await LocalSource().database;
    int result = await db.insert('Task', mapping(data));

    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteTask(TaskEntity data) async {
    var db = await LocalSource().database;
    int result = await db.delete('Task', where: 'id = ?', whereArgs: [data.id]);

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateTask(TaskEntity data) async {
    var db = await LocalSource().database;
    int result = await db.update(
      'Task',
      mapping(data),
      where: 'id = ?',
      whereArgs: [data.id],
    );

    return result != 0 ? true : false;
  }

  List<TaskEntity> _convertToEntities(List<Map<String, dynamic>> data) {
    List<TaskEntity> result = <TaskEntity>[];
    if (data.isNotEmpty) {
      for (var task in data) {
        result.add(TaskModel.from(task));
      }
    }

    return result;
  }

  Map<String, dynamic> mapping(TaskEntity data) {
    return <String, dynamic>{
      'id': data.id,
      'project_id': data.projectId,
      'title': data.title,
      'note': data.note,
      'is_done': data.isDone ? 1 : 0,
      'is_important': data.isImportant ? 1 : 0,
      'due_date': data.dueDate != null ? data.dueDate.toString() : null,
      'created_date': data.createdDate.toString(),
    };
  }
}
