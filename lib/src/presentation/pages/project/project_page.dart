import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/pages/project/project_page_bloc.dart';
import 'package:tasks/src/presentation/pages/task/task_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/new_task_form.dart';
import 'package:tasks/src/provider.dart';

class ProjectPage extends StatefulWidget {
  final ProjectModel project;

  ProjectPage({@required this.project});

  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> {
  ProjectPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProjectPageBloc(project: widget.project);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  /// Build a project page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerPage(widget.project),
      body: _bodyPage(widget.project)
    );
  }

  /// Build header this page.
  Widget _headerPage(ProjectModel object) {
    Widget _title = Text(object.title);

    return AppBar(
      title: _title
    );
  }

  /// Build body this page.
  Widget _bodyPage(ProjectModel object) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: _mainContent()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Icon(Icons.add),
                onPressed: () { // Show new task dialog.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NewTaskForm(projectId: object.id);
                    }
                  ).then((task) => _bloc.addTask(task));
                }
              )
            ]
          )
        ]
      )
    );
  }

  /// Build main content this page.
  Widget _mainContent() {
    return StreamBuilder(
      stream: _bloc.streamTasks,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return _buildListView(snapshot.data);
          } else {
            return EmptyContentBox(message: 'not task found');
          }
        }
      }
    );
  }

  /// Build a listview to show tasks.
  Widget _buildListView(List<TaskModel> tasks) {
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (content, index) {
        return Divider(color: Colors.grey);
      },
      itemBuilder: (context, int index) {
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
        value: task.done,
        onChanged: (bool checked) {
          task.done = checked;
          _bloc.updateTask(task);
        }
      ),
      title: Text(
        task.title,
        style: TextStyle(
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
          _bloc.updateTask(task);
          Provider.of<HomePageBloc>(context).announceImportantTasks();
        }
      ),
      onTap: () { // Open a task page.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskPage(task: task)
          )
        );
      },
    );
  }
}
