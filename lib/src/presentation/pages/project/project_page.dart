import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/forms/task_new_form.dart';

import 'project_controller.dart';
import 'widgets/page_body.dart';
import 'widgets/page_header.dart';

class ProjectPage extends StatefulWidget {
  /// Create a ProjectPage widget.
  ProjectPage({
    Key key,
    @required this.model,
  }): super(key: key);

  final ProjectModel model;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectController controller;
  ProjectModel model;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.model = this.widget.model;
    this.controller = ProjectController(this.model);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(ProjectPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  /// Build the ProjectPage widget with state.
  @override
  Widget build(BuildContext context) {
    return Component<ProjectController>.value(
      value: this.controller,
      child: this.buildPage(),
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: this.model.color,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(model: this.model),
            PageBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3.0,
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () async {
          final result = await showDialog(
            context: this.context,
            builder: (BuildContext context) {
              return TaskNewForm(project: this.model.id);
            },
          );

          if (result is TaskModel) {
            this.controller.addTask(result);
          }
        },
      ),
    );
  }
}
