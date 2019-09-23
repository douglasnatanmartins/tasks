import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/project/project_page_bloc.dart';
import 'package:tasks/src/presentation/pages/task/task_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/new_task_form.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class ProjectPage extends StatefulWidget {
  final ProjectModel project;

  ProjectPage({
    Key key,
    @required this.project
  }): assert(project != null), super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = ProjectPageBloc(project: widget.project);
    this.bloc.refreshTasks();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build a project page.
  @override
  Widget build(BuildContext context) {
    return buildPage(this.widget.project);
  }

  Widget buildPage(ProjectModel project) {
    return Scaffold(
      backgroundColor: UIColors.Green,
      body: bodyPage(project),
      floatingActionButton: FloatingActionButton(
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

  /// Build body this page.
  Widget bodyPage(ProjectModel object) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          headerPage(object),
          bodyContent()
        ]
      )
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

  /// Build main content this page.
  Widget bodyContent() {
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: this.bloc.streamTasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return _buildListView(snapshot.data);
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
  Widget _buildListView(List<TaskModel> tasks) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      itemCount: tasks.length,
      separatorBuilder: (content, index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];
        return _buildChildrenInListView(task);
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
      leading: Checkbox(
        checkColor: UIColors.Green,
        activeColor: Colors.white,
        value: task.done,
        onChanged: (bool checked) {
          task.done = checked;
          this.bloc.updateTask(task);
        }
      ),
      title: Text(
        task.title,
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
      onTap: () async { // Open a task page.
        Navigator.of(this.context).push(
          MaterialPageRoute(
            builder: (context) => TaskPage(task: task)
          )
        ).then((_) {
          this.bloc.refreshTasks();
        });
      },
    );
  }
}
