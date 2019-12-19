import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/utils/data_support.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    int id,
    @required int categoryId,
    @required String title,
    @required Color color,
    @required IconData icon,
    @required DateTime createdDate,
    String description,
  }): super(
    id: id,
    categoryId: categoryId,
    title: title,
    description: description,
    color: color,
    icon: icon,
    createdDate: createdDate,
  );

  factory ProjectModel.from(Map<String, dynamic> object) {
    return ProjectModel(
      id: object['id'],
      categoryId: object['category_id'],
      title: object['title'],
      description: object['description'],
      color: Color(int.parse(object['color'])),
      icon: DataSupport.icons[object['icon']],
      createdDate: DateTime.parse(object['created_date']),
    );
  }
}
