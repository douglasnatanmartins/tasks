import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/model_contract.dart';
import 'package:tasks/src/utils/data_support.dart';

class ProjectModel implements ModelContract{
  int _id;
  String _title;
  String _description;
  int _categoryId;
  DateTime _created;
  Color _color;
  IconData _icon;

  int get id => this._id;
  String get title => this._title;
  String get description => this._description;
  int get categoryId => this._categoryId;
  DateTime get created => this._created;
  Color get color => this._color;
  IconData get icon => this._icon;

  set title(String title) {
    this._title = title;
  }

  set description(String description) {
    this._description = description;
  }

  set categoryId(int categoryId) {
    this._categoryId = categoryId;
  }

  set color(Color color) {
    this._color = color;
  }

  set icon(IconData icon) {
    this._icon = icon;
  }

  /// Constructor of a project model object.
  ProjectModel({
    int id,
    @required String title,
    @required String description,
    @required int categoryId,
    @required DateTime created,
    @required Color color,
    @required IconData icon
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._categoryId = categoryId;
    this._created = created;
    this._color = color;
    this._icon = icon;
  }

  /// Constructor of a project model object from a Map object.
  ProjectModel.from(Map<String, dynamic> project) {
    this._id = project['id'];
    this._title = project['title'];
    this._description = project['description'];
    this._categoryId = project['category_id'];
    this._created = DateTime.parse(project['created']);
    this._color = Color(int.parse(project['color']));
    this._icon = DataSupport.icons[project['icon']];
  }

  // Returns a map object to representation of this model object.
  @override
  Map<String, dynamic> toMap() {
    final icons = DataSupport.icons;
    String icon = icons.keys.firstWhere((String key) {
      if (icons[key] == this._icon) {
        return true;
      } else {
        return false;
      }
    });

    var project = Map<String, dynamic>();
    project['id'] = this._id;
    project['title'] = this._title;
    project['description'] = this._description;
    project['category_id'] = this._categoryId;
    project['created'] = this._created.toString();
    project['color'] = this._color.value.toString();
    project['icon'] = icon;
    return project;
  }
}
