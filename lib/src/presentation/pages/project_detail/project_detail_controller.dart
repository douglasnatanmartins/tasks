import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';

class ProjectDetailController implements Controller {
  ProjectDetailController({
    ProjectEntity project,
  }): assert(project != null),
      _project = project;

  final _projectColorSubject = StreamController<Color>();
  Stream<Color> get colorStream => _projectColorSubject.stream;

  ProjectEntity _project;
  ProjectEntity get project => _project;

  void setProjectTitle(String title) {
    _project = _project.copyWith(title: title);
  }

  void setProjectDescription(String description) {
    _project = _project.copyWith(description: description);
  }

  void setProjectColor(Color color) {
    _project = _project.copyWith(color: color);
    _projectColorSubject.add(color);
  }

  void setProjectIcon(IconData icon) {
    _project = _project.copyWith(icon: icon);
  }

  @override
  void dispose() {
    _projectColorSubject.close();
  }
}
