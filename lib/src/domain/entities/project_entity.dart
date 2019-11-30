import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class ProjectEntity implements Entity<ProjectEntity> {
  /// Create a project entity.
  /// 
  /// The [categoryId], [title], [color], [icon] and [createdDate] arguments
  /// must not be null.
  ProjectEntity({
    @required this.id,
    @required this.categoryId,
    @required this.title,
    @required this.description,
    @required this.color,
    @required this.icon,
    @required this.createdDate,
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
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdDate: this.createdDate,
    );
  }

  @override
  String toString() {
    String str = '[Project Id: ${this.id}] - ';
    str += 'title: ${this.title},';
    str += 'description: ${this.description},';
    str += 'color: ${this.color},';
    str += 'icon: ${this.icon},';
    str += 'created date: ${this.createdDate}';
    return str;
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is ProjectEntity
        && object.id == this.id
        && object.title == this.title
        && object.description == this.description
        && object.color == this.color
        && object.icon == this.icon
        && object.createdDate == this.createdDate;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.categoryId.hashCode
         ^ this.title.hashCode
         ^ this.description.hashCode
         ^ this.color.hashCode
         ^ this.icon.hashCode
         ^ this.createdDate.hashCode;
  }
}
