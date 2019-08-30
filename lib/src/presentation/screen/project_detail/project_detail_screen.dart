import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/screen/project_detail/project_detail_screen_bloc.dart';
import 'package:tasks/src/presentation/screen/task_detail/task_detail_screen.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectEntity project;

  ProjectDetailScreen({Key key, @required this.project}):
    assert(project != null),
    super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProjectDetailScreenState();
  }
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  ProjectDetailScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProjectDetailScreenBloc(project: widget.project);
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.project,
      stream: _bloc.streamOfProject,
      builder: (context, snapshot) {
        return _buildUI(context, snapshot.data);
      }
    );
  }

  Widget _buildUI(BuildContext context, ProjectEntity project) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title)
      ),
      body: _buildBody(context, project),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await _buildForm(context);
          if (result is TaskEntity) {
            _bloc.addTask(result);
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProjectEntity project) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              initialData: project.tasks,
              stream: _bloc.streamOfTasks,
              builder: (context, snapshot) {
                final List<TaskEntity> source = snapshot.data;
                return ListView.builder(
                  itemCount: source.length,
                  itemBuilder: (context, index) {
                    final task = source[index];
                    return ListTile(
                      leading: Checkbox(
                        value: task.done,
                        onChanged: (bool checked) {
                          _bloc.taskIsDone(task, checked);
                        }
                      ),
                      title: Text(task.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(task: task)
                          )
                        );
                      },
                      trailing: PopupMenuButton(
                        onSelected: (action) {
                          if (action == 'delete') {
                            _bloc.removeTask(task);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text("Delete")
                              )
                            )
                          ];
                        }
                      ),
                    );
                  }
                );
              }
            )
          )
        ],
      )
    );
  }

  _buildForm(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text("New Task"),
          content: TextField(
            controller: controller,
            autofocus: true
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                controller.clear();
                Navigator.pop(context);
              }
            ),
            FlatButton(
              child: Text("Add"),
              onPressed: () {
                final task = TaskEntity(title: controller.value.text);
                controller.clear();
                Navigator.of(context).pop(task);
              }
            )
          ],
        );
      }
    );
  }
}
