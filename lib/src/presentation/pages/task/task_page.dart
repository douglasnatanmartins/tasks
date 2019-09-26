import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/task_page_bloc.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;

  TaskPage({
    Key key,
    @required this.task
  }): assert(task != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = TaskPageBloc(this.widget.task);
    this.bloc.refreshSteps();
  }

  /// Called when this state removed from tree.
  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return this.buildPage(this.widget.task);
  }

  /// Build a task page.
  Widget buildPage(TaskModel task) {
    return Scaffold(
      backgroundColor: UIColors.Blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(task),
            this.bodyPage(),
            this.footerPage(task)
          ],
        )
      )
    );
  }

  /// Build header this page.
  Widget headerPage(TaskModel task) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
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
            child: editorTitleTask(task)
          ),
          Hero(
            tag: 'floating-button',
            child: FlatButton(
              padding: EdgeInsets.all(12.0),
              color: Colors.white,
              shape: CircleBorder(),
              child: Icon(Icons.delete),
              textColor: UIColors.LightRed,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
          )
        ]
      )
    );
  }

  /// Build editable title.
  Widget editorTitleTask(TaskModel task) {
    final TextEditingController controller = TextEditingController(text: task.title);
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.75),
              width: 0.25
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.85),
              width: 0.5
            )
          )
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
  Widget bodyPage() {
    return Expanded(
      child: StreamBuilder(
        stream: this.bloc.streamSteps,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator()
            );
          } else {
            return this.buildListView(snapshot.data);
          }
        }
      )
    );
  }

  /// Build a listview to show steps of task.
  Widget buildListView(List<StepModel> steps) {
    List<ListTile> tiles = [];

    steps.forEach((step) {
      tiles.add(this._buildChildrenInListView(step));
    });

    tiles.add(this._buildChildrenInListView(
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
        onChanged: (bool checked) {
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
        onSubmitted: (String text) {
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

  /// Build footer this page.
  Widget footerPage(TaskModel task) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: this._buildNoteForm(task)
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
        onChanged: (String value) {
          task.note = _controller.text;
          this.bloc.updateTask(task);
        }
      )
    );
  }
}
