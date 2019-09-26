import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';

class StepRepository {
  /// Get all steps.
  Future<List<Map<String, dynamic>>> all() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Step");
    return result;
  }

  /// Get all steps with task id.
  Future<List<Map<String, dynamic>>> getStepsByTaskId(int stepId) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Step WHERE taskId = ?", [stepId]);
    return result;
  }

  /// Get step with id.
  Future<Map<String, dynamic>> getStepById(int id) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Step WHERE id = ?", [id]);
    if (result.length > 0) {
      return result[0];
    }

    return null;
  }

  /// Add new step.
  Future<bool> add(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.insert('Step', object);
    return result != 0 ? true : false;
  }

  /// Delete step with id.
  Future<bool> delete(int id) async {
    Database db = await DatabaseCreator().database;
    int result = await db.delete('Step', where: 'id = ?', whereArgs: [id]);
    return result != 0 ? true : false;
  }

  /// Update step with id.
  Future<bool> update(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.update('Step', object, where: 'id = ?', whereArgs: [object['id']]);
    return result != 0 ? true : false;
  }
}
