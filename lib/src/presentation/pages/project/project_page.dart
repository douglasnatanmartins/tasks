import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/task_new_form.dart';

import 'project_page_bloc.dart';
import 'widgets/task_list_view.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({
    Key key,
    @required this.project
  }): assert(project != null),
      super(key: key);

  final ProjectModel project;

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    // Create business logic component.
    this.bloc = ProjectPageBloc(this.widget.project);
    this.bloc.refreshTasks();
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    // Close business logic component.
    this.bloc.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return this.buildPage(this.widget.project);
  }

  /// Build a project page.
  Widget buildPage(ProjectModel project) {
    return Scaffold(
      backgroundColor: project.color,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(project),
            this.bodyPage(),
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
            builder: (BuildContext context) => TaskNewForm(project: project.id)
          );

          if (result is TaskModel) {
            this.bloc.addTask(result);
          }
        },
      ),
    );
  }

  /// Build header this page.
  Widget headerPage(ProjectModel object) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(this.context).pop(),
            ),
          ),
          Expanded(
            child: Text(
              object.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Edit project button.
          FlatButton(
            padding: EdgeInsets.all(12.0),
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 4.0,
              ),
            ),
            child: const Icon(Icons.edit),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(this.context).pushNamed('/project/task');
            },
          ),
        ],
      ),
    );
  }

  /// Build body this page.
  Widget bodyPage() {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: this.bloc.streamTasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return TaskListView(
                  data: snapshot.data,
                  onChanged: (TaskModel task) {
                    this.bloc.updateTask(task);
                  },
                  whenOpened: () {
                    this.bloc.refreshTasks();
                  },
                );
              } else {
                return EmptyContentBox(
                  message: 'not task found',
                  textColor: Colors.white.withOpacity(0.75),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
