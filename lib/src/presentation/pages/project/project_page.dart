import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/domain/entities/project_entity.dart';
import '../../controllers/project_manager_contract.dart';
import 'project_controller.dart';
import 'project_layout.dart';

class ProjectPageArguments {
  ProjectPageArguments({
    this.key,
    @required this.manager,
    @required this.project,
  }): assert(manager != null),
      assert(project != null);

  final Key key;
  final ProjectManagerContract manager;
  final ProjectEntity project;
}

class ProjectPage extends StatelessWidget {
  /// Create a ProjectPage widget.
  /// 
  /// The [arguments] argument must not be null.
  ProjectPage({
    @required this.arguments,
  }): assert(arguments != null),
      super(key: arguments.key);

  final ProjectPageArguments arguments;

  /// Build the ProjectPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<ProjectManagerContract>.component(
      component: arguments.manager,
      notifier: (current, previous) => false,
      child: Provider<ProjectController>(
        creator: (context) => ProjectController(arguments.project),
        disposer: (context, controller) => controller?.dispose(),
        child: ProjectLayout(data: arguments.project),
      ),
    );
  }
}
