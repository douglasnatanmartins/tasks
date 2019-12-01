import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/forms/task_new_form.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'project_controller.dart';

part 'widgets/page_body.dart';
part 'widgets/page_header.dart';
part 'widgets/task_list_tile.dart';
part 'widgets/task_list_view.dart';

class ProjectPage extends StatefulWidget {
  /// Create a ProjectPage widget.
  ///
  /// The [model] argument must not be null.
  ProjectPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  final ProjectEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectController controller;
  ProjectEntity data;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.controller = ProjectController(this.data);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(ProjectPage old) {
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

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
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: this.data.color,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                _PageHeader(data: this.data),
                _PageBody(),
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
                  return TaskNewForm(project: this.data.id);
                },
              );

              if (result is TaskEntity) {
                this.controller.addTask(result);
              }
            },
          ),
        );
      },
    );
  }
}
