import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/task_page_bloc.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;

  TaskPage({Key key, @required this.task}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }
}

class _TaskPageState extends State<TaskPage> {
  TaskPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = TaskPageBloc(task: widget.task);
    this.bloc.refreshSteps();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build a task page.
  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: UIColors.Blue,
      body: bodyPage(this.widget.task)
    );
  }

  /// Build body this page.
  Widget bodyPage(TaskModel task) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          headerPage(task),
          Expanded(
            child: bodyContent()
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: _buildNoteForm(task)
          )
        ],
      )
    );
  }

  /// Build header this page.
  Widget headerPage(TaskModel task) {
    return Container(
      height: 100.0,
      child: Row(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            shape: CircleBorder(),
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(this.context).pop()
          ),
          Expanded(
            child: editorTitleTask(task)
          ),
          FlatButton(
            padding: EdgeInsets.all(12.0),
            color: Colors.white,
            shape: CircleBorder(),
            child: Icon(Icons.delete),
            textColor: UIColors.LightRed,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _dialogWhenDeleteTask();
                }
              ).then((result) {
                if (result != null && result) {
                  this.bloc.deleteTask(task).then((_) {
                    Navigator.of(this.context).pop();
                  });
                }
              });
            }
          )
        ]
      )
    );
  }

  Widget editorTitleTask(TaskModel task) {
    final TextEditingController controller = TextEditingController(text: task.title);
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600
        ),
        cursorColor: Colors.white,
        onChanged: (String content) {
          if (content.trim().length >= 2) {
            task.title = content;
            this.bloc.updateTask(task);
          }
        },
      )
    );
  }

  /// Build dialog when delete category.
  Widget _dialogWhenDeleteTask() {
    return AlertDialog(
      content: Text("Are you sure delete this task?"),
      actions: <Widget>[
        // Yes Button.
        FlatButton(
          color: Theme.of(context).errorColor,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          }
        ),
        // Cancel button.
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.grey)
          ),
          onPressed: () { // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          }
        )
      ]
    );
  }

  /// Build main content this page.
  Widget bodyContent() {
    return StreamBuilder(
      stream: this.bloc.streamSteps,
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
      padding: EdgeInsets.all(0.0),
      children: tiles
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(StepModel step) {
    final controller = TextEditingController(text: step.title);

    return ListTile(
      leading: Checkbox(
        activeColor: Colors.white.withOpacity(0),
        value: step.done,
        onChanged: (checked) {
          if (step.id != null) {
            step.done = checked;
            this.bloc.updateStep(step);
          }
        }
      ),
      title: TextField(
        controller: controller,
        cursorColor: Colors.white.withOpacity(0.85),
        decoration: InputDecoration(
          hintText: "Enter step",
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5)
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5)
            )
          )
        ),
        style: TextStyle(
          color: Colors.white
        ),
        onSubmitted: (text) {
          if (text.trim().isNotEmpty) {
            step.title = text.trim();
            if (step.id != null) {
              this.bloc.updateStep(step);
            } else {
              this.bloc.addStep(step);
            }
          }
        }
      ),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        color: Colors.white,
        onPressed: () {
          if (step.id != null) {
            this.bloc.deleteStep(step);
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
          this.bloc.updateTask(task);
        }
      )
    );
  }
}
