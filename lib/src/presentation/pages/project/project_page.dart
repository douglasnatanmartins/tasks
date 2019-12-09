import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/domain/entities/project_entity.dart';
import 'project_controller.dart';
import 'project_layout.dart';

class ProjectPage extends StatelessWidget {
  /// Create a ProjectPage widget.
  ProjectPage({
    Key key,
    @required this.data,
  }): super(key: key);

  final ProjectEntity data;

  /// Build the ProjectPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<ProjectController>(
      creator: (context) => ProjectController(data),
      disposer: (context, component) => component.dispose(),
      child: ProjectLayout(data: this.data),
    );
  }
}
