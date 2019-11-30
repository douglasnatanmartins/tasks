import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/domain/repositories/task_repository_contract.dart';

class TaskRepository implements TaskRepositoryContract {
  @override
  Future<List<TaskEntity>> getAll() async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query('Task');
    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllDueDateTask() async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query(
      'Task',
      where: 'due_date IS NOT NULL',
      orderBy: 'due_date ASC',
    );
    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllImportantTask() async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query(
      'Task',
      where: 'is_important = 1',
      orderBy: 'due_date ASC',
    );
    return _convertToEntities(data);
  }

  @override
  Future<List<TaskEntity>> getAllTaskByProjectId(int projectId) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query(
      'Task',
      where: 'project_id = ?',
      whereArgs: [projectId]
    );
    return _convertToEntities(data);
  }

  @override
  Future<TaskEntity> getTaskById(int id) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query(
      'Task',
      where: 'id = ?',
      whereArgs: [id]
    );

    if (data != null) {
      return TaskModel.from(data.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createTask(TaskEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.insert('Task', mapping(entity));
    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteTask(TaskEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.delete('Task', where: 'id = ?', whereArgs: [entity.id]);

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateTask(TaskEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.update(
      'Task',
      mapping(entity),
      where: 'id = ?',
      whereArgs: [entity.id]
    );

    return result != 0 ? true : false;
  }

  List<TaskEntity> _convertToEntities(List<Map<String, dynamic>> data) {
    if (data.isNotEmpty) {
      List<TaskEntity> result = data.map<TaskEntity>((Map<String, dynamic> item) {
        return TaskModel.from(item);
      }).toList();
      return result;
    }

    return <TaskEntity>[];
  }

  Map<String, dynamic> mapping(TaskEntity entity) {
    return <String, dynamic>{
      'id': entity.id,
      'project_id': entity.projectId,
      'title': entity.title,
      'note': entity.note,
      'is_done': entity.isDone ? 1 : 0,
      'is_important': entity.isImportant ? 1 : 0,
      'due_date': entity.dueDate != null ? entity.dueDate.toString() : null,
      'created_date': entity.createdDate.toString(),
    };
  }
}
