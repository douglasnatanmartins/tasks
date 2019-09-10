import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/task_page_bloc.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;

  TaskPage({@required this.task});

  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }
}

class _TaskPageState extends State<TaskPage> {
  TaskPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskPageBloc(task: widget.task);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerPage(widget.task),
      body: _bodyPage(widget.task)
    );
  }

  Widget _headerPage(TaskModel task) {
    return AppBar(
      title: Text(task.title)
    );
  }

  Widget _bodyPage(TaskModel task) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 360,
              child: _buildContent()
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: _buildNote(task)
            )
          ],
        )
      )
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
      stream: _bloc.streamSteps,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data);
          } else {
            return Center(
              child: Text('Empty')
            );
          }
        }
      }
    );
  }

  Widget _buildListView(List<StepModel> steps) {
    List<ListTile> tiles = [];

    steps.forEach((step) {
      tiles.add(_buildRow(step));
    });

    tiles.add(_buildRow(StepModel(id: null, title: '', done: false, taskId: widget.task.id)));

    return ListView(
      children: tiles
    );
  }

  Widget _buildRow(StepModel step) {
    TextEditingController _controller = TextEditingController(text: step.title);

    return ListTile(
      leading: Checkbox(
        value: step.done,
        onChanged: (checked) {
          if (step.id != null) {
            step.done = checked;
            _bloc.updateStep(step);
          }
        }
      ),
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Enter step"
        ),
        onSubmitted: (text) {
          if (text.trim().isNotEmpty) {
            step.title = text.trim();
            if (step.id != null) {
              _bloc.updateStep(step);
            } else {
              _bloc.addStep(step);
            }
          }
        }
      ),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          if (step.id != null) {
            _bloc.deleteStep(step);
          }
        }
      ),
    );
  }

  Widget _buildNote(TaskModel task) {
    final _controller = TextEditingController(text: task.note);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Note'
      ),
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: 3
    );
  }
}
