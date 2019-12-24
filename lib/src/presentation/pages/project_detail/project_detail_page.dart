import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/utils/data_support.dart';

import 'project_detail_controller.dart';
import 'project_detail_layout.dart';

class ProjectDetailPage extends StatelessWidget {
  /// Create a ProjectDetailPage widget.
  ProjectDetailPage({
    Key key,
    this.project,
    this.categoryId,
  }): assert(project != null || categoryId != null),
      super(key: key);

  final ProjectEntity project;
  final int categoryId;

  /// Build the ProjectDetailPage widget.
  @override
  Widget build(BuildContext context) {
    ProjectEntity data;
    if (project != null) {
      data = project;
    } else {
      data = ProjectEntity(
        categoryId: categoryId,
        title: '',
        color: DataSupport.colors.values.elementAt(0),
        icon: DataSupport.icons.values.elementAt(0),
        createdDate: DateTime.now(),
      );
    }

    return Provider<ProjectDetailController>(
      creator: (context) {
        return ProjectDetailController(project: data);
      },
      disposer: (context, controller) {
        controller?.dispose();
      },
      child: ProjectDetailLayout(),
    );
  }
}
