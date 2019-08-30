import 'package:flutter/foundation.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

class ProjectEntity {
  String _title;
  String _description;
  List<TaskEntity> _tasks;

  String get title => _title;
  set title(String title) => _title = title;

  String get description => _description;
  set description(String description) => _description = description;

  List<TaskEntity> get tasks => _tasks;
  set tasks(List<TaskEntity> tasks) => _tasks = tasks;

  ProjectEntity({
    @required String title,
    String description = ''
  }) {
    _title = title;
    _description = description;
    _tasks = [];
  }
}
