import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class ProjectEntity implements Entity<ProjectEntity> {
  /// Create a project entity.
  /// 
  /// The [categoryId], [title], [color], [icon] and [createdDate] arguments
  /// must not be null.
  ProjectEntity({
    this.id,
    @required this.categoryId,
    @required this.title,
    @required this.color,
    @required this.icon,
    @required this.createdDate,
    this.description,
  }): assert(categoryId != null),
      assert(title != null),
      assert(color != null),
      assert(icon != null),
      assert(createdDate != null);

  final int id;
  final int categoryId;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final DateTime createdDate;

  @override
  ProjectEntity copyWith({
    int categoryId,
    String title,
    String description,
    Color color,
    IconData icon,
  }) {
    return ProjectEntity(
      id: this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description != null && description.isNotEmpty
                    ? description
                    : null,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdDate: this.createdDate,
    );
  }

  @override
  String toString() {
    return '[Project Id: $id] - '
    'title: $title, '
    'description: $description, '
    'color: $color, '
    'icon: $icon, '
    'created date: $createdDate.';
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is ProjectEntity
        && object.id == id
        && object.title == title
        && object.description == description
        && object.color == color
        && object.icon == icon
        && object.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode
         ^ categoryId.hashCode
         ^ title.hashCode
         ^ description.hashCode
         ^ color.hashCode
         ^ icon.hashCode
         ^ createdDate.hashCode;
  }
}
