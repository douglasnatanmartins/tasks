import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';
import 'package:tasks/src/data/repositories/step_repository.dart';

class TaskRepository {
  StepRepository _stepRepository;

  TaskRepository() {
    _stepRepository = StepRepository();
  }

  /// Get all tasks.
  Future<List<Map<String, dynamic>>> all() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task");
    return result;
  }

  /// Get all important tasks.
  Future<List<Map<String, dynamic>>> allImportantTasks() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM Task WHERE important = 1');
    return result;
  }

  /// Get all tasks with project id.
  Future<List<Map<String, dynamic>>> getTasksByProjectId(int projectId) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task WHERE projectId = ?", [projectId]);
    return result;
  }

  /// Get task with id.
  Future<Map<String, dynamic>> getTaskById(int id) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task WHERE id = ?", [id]);
    if (result.length > 0) {
      return result[0];
    }

    return null;
  }

  /// Add new task.
  Future<bool> add(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.insert('Task', object);
    return result != 0 ? true : false;
  }

  /// Delete task by id.
  Future<bool> delete(int id) async {
    Database db = await DatabaseCreator().database;
    // Delete all steps owned by task.
    await _stepRepository.deleteStepsByTaskId(id);
    // After delete task.
    int result = await db.delete('Task', where: 'id = ?', whereArgs: [id]);
    return result != 0 ? true : false;
  }

  /// Delete all tasks with project id.
  Future<bool> deleteTasksByProjectId(int projectId) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> tasks = await db.query('Task', where: 'projectId = ?', whereArgs: [projectId]);
    bool result = false;
    tasks.forEach((task) async {
      result = await delete(task['id']);
    });
    return result;
  }

  /// Update task with id.
  Future<bool> update(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.update('Task', object, where: 'id = ?', whereArgs: [object['id']]);
    return result != 0 ? true : false;
  }
}
