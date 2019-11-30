import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/repositories/step_repository_contract.dart';

class StepRepository implements StepRepositoryContract{
  @override
  Future<List<StepEntity>> getAll() async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query('Step');
    return this._convertToEntities(data);
  }

  @override
  Future<List<StepEntity>> getAllStepByTaskId(int taskId) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query('Step', where: 'task_id = ?', whereArgs: [taskId]);
    return this._convertToEntities(data);
  }

  @override
  Future<StepEntity> getStepById(int id) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> result = await db.query('Step', where: 'id = ?', whereArgs: [id]);
    if (result.length > 0) {
      return StepModel.from(result.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createStep(StepEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.insert('Step', mapping(entity));
    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteStep(StepEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.delete('Step', where: 'id = ?', whereArgs: [entity.id]);
    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateStep(StepEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.update(
      'Step',
      mapping(entity),
      where: 'id = ?',
      whereArgs: [entity.id]
    );
    return result != 0 ? true : false;
  }

  List<StepEntity> _convertToEntities(List<Map<String, dynamic>> data) {
    if (data.isNotEmpty) {
      List<StepEntity> result = data.map<StepEntity>((Map<String, dynamic> item) {
        return StepModel.from(item);
      }).toList();
      return result;
    }

    return null;
  }

  Map<String, dynamic> mapping(StepEntity entity) {
    return <String, dynamic>{
    'id': entity.id,
    'task_id': entity.taskId,
    'message': entity.message,
    'is_done': entity.isDone ? 1 : 0,
    };
  }
}
