import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/widgets/editable_title.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import 'task_page_bloc.dart';
import 'widgets/note_textfield.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;

  const TaskPage({
    Key key,
    @required this.task
  }): assert(task != null),
      super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskPageBloc bloc;
  TaskModel task;
  String title;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.bloc = TaskPageBloc(this.widget.task);
    this.task = this.widget.task;
    this.title = this.task.title;
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
    return WillPopScope(
      onWillPop: () async {
        if (this.title.isNotEmpty) {
          this.task.title = this.title;
          await this.bloc.updateTask(this.task);
        }

        return true;
      },
      child: Scaffold(
        body: this.buildPage()
      ),
    );
  }

  /// Build a task page.
  Widget buildPage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          this.headerPage(),
          this.bodyPage(),
          this.footerPage()
        ],
      )
    );
  }

  /// Build header this page.
  Widget headerPage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: <Widget>[
          // Back previous screen button.
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.grey,
              shape: CircleBorder(),
              child: Icon(Icons.arrow_back),
              onPressed: () async {
                if (this.title.isNotEmpty) {
                  this.task.title = this.title;
                  await this.bloc.updateTask(task);
                }
                Navigator.of(this.context).pop();
              }
            )
          ),
          Expanded(
            child: editableTitle()
          ),
          Hero(
            tag: 'floating-button',
            child: FlatButton(
              padding: EdgeInsets.all(12.0),
              color: Colors.red,
              shape: CircleBorder(),
              child: Icon(Icons.delete),
              textColor: Colors.white,
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _dialogWhenDeleteTask();
                  }
                );

                if (result != null && result) {
                  if (await this.bloc.deleteTask(task)) {
                    Navigator.of(this.context).pop();
                  }
                }
              }
            )
          )
        ]
      )
    );
  }

  /// Build editable title.
  Widget editableTitle() {
    return EditableTitle(
      title: this.task.title,
      onChanged: (String newTitle) {
        this.title = newTitle;
      }
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
      key: UniqueKey(),
      leading: CircleCheckbox(
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
        cursorColor: Colors.blue.withOpacity(0.85),
        decoration: InputDecoration(
          hintText: "Enter step",
          hintStyle: TextStyle(
            color: Colors.blue.withOpacity(0.5)
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.5)
            )
          )
        ),
        style: TextStyle(
          color: Colors.black.withOpacity(0.85)
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
        color: Colors.red,
        onPressed: () {
          if (step.id != null) {
            this.bloc.deleteStep(step);
          }
        }
      ),
    );
  }

  /// Build footer this page.
  Widget footerPage() {
    return Column(
      children: <Widget>[
        DatePicker(
          title: 'Add due date',
          icon: Icons.date_range,
          initialDate: this.task.dueDate,
          onSelected: (DateTime date) async {
            this.task.dueDate = date;
            await this.bloc.updateTask(this.task);
          },
        ),
        this.buildNoteForm(this.task)
      ],
    );
  }

  /// Build the task note form.
  Widget buildNoteForm(TaskModel task) {
    return NoteTextField(
      note: task.note,
      onChanged: (String note) {
        task.note = note;
        this.bloc.updateTask(task);
      }
    );
  }
}
