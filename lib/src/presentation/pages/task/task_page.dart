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

  /// Build a task page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerPage(widget.task),
      body: _bodyPage(widget.task)
    );
  }

  /// Build header this page.
  Widget _headerPage(TaskModel task) {
    return AppBar(
      title: Text(task.title)
    );
  }

  /// Build body this page.
  Widget _bodyPage(TaskModel task) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 15.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _mainContent()
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: _buildNoteForm(task)
          )
        ],
      )
    );
  }

  /// Build main content this page.
  Widget _mainContent() {
    return StreamBuilder(
      stream: _bloc.streamSteps,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          return _buildListView(snapshot.data);
        }
      }
    );
  }

  /// Build a listview to show steps of task.
  Widget _buildListView(List<StepModel> steps) {
    List<ListTile> tiles = [];

    steps.forEach((step) {
      tiles.add(_buildChildrenInListView(step));
    });

    tiles.add(_buildChildrenInListView(
      StepModel(id: null, title: '', done: false, taskId: widget.task.id)
    ));

    return ListView(
      children: tiles
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(StepModel step) {
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
        icon: Icon(Icons.clear),
        color: Colors.red,
        onPressed: () {
          if (step.id != null) {
            _bloc.deleteStep(step);
          }
        }
      ),
    );
  }

  /// Build the task note form.
  Widget _buildNoteForm(TaskModel task) {
    final _controller = TextEditingController(text: task.note);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.2)
        ),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3.0,
            offset: Offset(0.5, 4)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Note',
          border: InputBorder.none
        ),
        controller: _controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: (string) {
          task.note = _controller.text;
          _bloc.updateTask(task);
        }
      )
    );
  }
}
