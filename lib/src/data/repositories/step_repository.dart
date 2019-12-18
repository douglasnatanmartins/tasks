import 'dart:async';

import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/repositories/step_repository_contract.dart';

class StepRepository implements StepRepositoryContract{
  @override
  Future<List<StepEntity>> getAll() async {
    var db = await LocalSource().database;
    var data = await db.query('Step');
    return _convertToEntities(data);
  }

  @override
  Future<List<StepEntity>> getAllStepByTaskId(int taskId) async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Step',
      where: 'task_id = ?',
      whereArgs: [taskId],
    );

    return _convertToEntities(data);
  }

  @override
  Future<StepEntity> getStepById(int id) async {
    var db = await LocalSource().database;
    var result = await db.query('Step', where: 'id = ?', whereArgs: [id]);
    if (result.length > 0) {
      return StepModel.from(result.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createStep(StepEntity data) async {
    var db = await LocalSource().database;
    int result = await db.insert('Step', mapping(data));

    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteStep(StepEntity data) async {
    var db = await LocalSource().database;
    int result = await db.delete('Step', where: 'id = ?', whereArgs: [data.id]);

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateStep(StepEntity data) async {
    var db = await LocalSource().database;
    int result = await db.update(
      'Step',
      mapping(data),
      where: 'id = ?',
      whereArgs: [data.id]
    );

    return result != 0 ? true : false;
  }

  List<StepEntity> _convertToEntities(List<Map<String, dynamic>> data) {
    List<StepEntity> result = <StepEntity>[];
    if (data.isNotEmpty) {
      for (var step in data) {
        result.add(StepModel.from(step));
      }
    }

    return result;
  }

  Map<String, dynamic> mapping(StepEntity data) {
    return <String, dynamic>{
    'id': data.id,
    'task_id': data.taskId,
    'message': data.message,
    'is_done': data.isDone ? 1 : 0,
    };
  }
}
