import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_list_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/screen/task_list_detail/task_list_detail_screen_bloc.dart';

class TaskListDetailScreen extends StatefulWidget {
  final TaskListModel list;

  TaskListDetailScreen({Key key, @required this.list}):
    assert(list != null),
    super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskListDetailScreenState();
  }
}

class _TaskListDetailScreenState extends State<TaskListDetailScreen> {
  TaskListDetailScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskListDetailScreenBloc(list: widget.list);
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.list,
      stream: _bloc.stream,
      builder: (context, snapshot) {
        return _buildUI(context, snapshot.data);
      }
    );
  }

  Widget _buildUI(BuildContext context, TaskListModel list) {
    return Scaffold(
      appBar: AppBar(
        title: Text(list.title)
      ),
      body: _buildBody(context, list),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await _buildForm(context);
          if (result is TaskModel) {
            _bloc.addTask(result);
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TaskListModel list) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              initialData: list.tasks,
              stream: _bloc.streamOfTasks,
              builder: (context, snapshot) {
                final List<TaskModel> source = snapshot.data;
                return ListView.builder(
                  itemCount: source.length,
                  itemBuilder: (context, index) {
                    final task = list.tasks[index];
                    return ListTile(
                      leading: Checkbox(
                        value: task.finished,
                        onChanged: (bool checked) {
                          _bloc.onFinished(index, checked);
                        },
                      ),
                      title: Text(task.title)
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
                final task = TaskModel(title: controller.value.text);
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
