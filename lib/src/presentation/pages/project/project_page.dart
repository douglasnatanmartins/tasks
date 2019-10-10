import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/task_page.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/new_task_form.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

import 'project_page_bloc.dart';

class ProjectPage extends StatefulWidget {
  final ProjectModel project;

  const ProjectPage({
    Key key,
    @required this.project
  }): assert(project != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    // Create business logic component.
    this.bloc = ProjectPageBloc(this.widget.project);

    // Refresh task list.
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
            this.bodyPage()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4.0
          )
        ),
        child: Icon(Icons.add),
        backgroundColor: UIColors.LightGreen,
        onPressed: () {
          showDialog(
            context: this.context,
            builder: (BuildContext context) {
              return NewTaskForm(projectId: project.id);
            }
          ).then((task) {
            if (task is TaskModel) {
              this.bloc.addTask(task);
            }
          });
        },
      ),
    );
  }

  /// Build header this page.
  Widget headerPage(ProjectModel object) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              shape: CircleBorder(),
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(this.context).pop()
            )
          ),
          Expanded(
            child: Text(
              object.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600
              )
            )
          ),
          FlatButton(
            padding: EdgeInsets.all(12.0),
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 4.0
              )
            ),
            child: Icon(Icons.edit),
            textColor: Colors.white,
            onPressed: () {}
          )
        ]
      )
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
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return this.buildListView(snapshot.data);
              } else {
                return EmptyContentBox(
                  message: 'not task found',
                  textColor: Colors.white.withOpacity(0.75),
                );
              }
            }
          }
        )
      )
    );
  }

  /// Build a listview to show tasks.
  Widget buildListView(List<TaskModel> tasks) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      itemCount: tasks.length,
      separatorBuilder: (BuildContext content, int index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];
        return this._buildChildrenInListView(task);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(TaskModel task) {
    TextDecoration _decoration = TextDecoration.none;

    if (task.done) {
      _decoration = TextDecoration.lineThrough;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: task.done,
        onChanged: (bool checked) {
          task.done = checked;
          this.bloc.updateTask(task);
        }
      ),
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: _decoration
        )
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: task.important ? Colors.yellow.shade600 : null
        ),
        onPressed: () {
          task.important = !task.important;
          this.bloc.updateTask(task);
        }
      ),
      onTap: () { // Open a task page.
        Navigator.of(this.context).pushNamed('/task', arguments: task)
          .then((_) => this.bloc.refreshTasks());
      },
    );
  }
}
