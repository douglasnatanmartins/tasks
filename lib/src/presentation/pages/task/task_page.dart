import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/task/widgets/editable_title.dart';
import 'package:tasks/src/presentation/pages/task/widgets/important_checkbox.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import 'task_page_bloc.dart';
import 'widgets/item_list_tile.dart';
import 'widgets/note_textfield.dart';

class TaskPage extends StatefulWidget {
  TaskPage({
    Key key,
    @required this.task
  }): assert(task != null),
      super(key: key);

  final TaskModel task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskPageBloc bloc;
  TaskModel task;
  String title;
  List<StepModel> steps;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = TaskPageBloc(this.widget.task);
    this.task = this.widget.task;
    this.title = this.task.title;
    this.bloc.refreshSteps();
  }

  @override
  void didUpdateWidget(TaskPage oldWidget) {
    if (oldWidget.task != this.widget.task) {
      this.task = this.widget.task;
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Called when this state removed from tree.
  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  Future<bool> update() async {
    if (this.title.isNotEmpty) {
      this.task.title = this.title;
    }

    await this.bloc.updateTask(this.task);
    return true;
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.update,
      child: Scaffold(
        body: this.buildPage(),
        backgroundColor: Colors.grey[200],
        bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Created: ${DateFormat.yMMMd().format(this.task.createdDate)}',
                  style: Theme.of(this.context).textTheme.subtitle.copyWith(
                    fontWeight: FontWeight.w300
                  )
                ),
                IconButton(
                  color: Colors.red[400],
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return this.dialogWhenDeleteTask();
                      }
                    );

                    if (result != null && result) {
                      if (await this.bloc.deleteTask(task)) {
                        Navigator.of(this.context).pop();
                      }
                    }
                  },
                )
              ],
            )
          )
        ),
      ),
    );
  }

  /// Build a task page.
  Widget buildPage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              this.headerPage(),
              this.bodyPage(),
              this.footerPage()
            ],
          ),
        )
      )
    );
  }

  /// Build header this page.
  Widget headerPage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Back previous screen button.
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10.0),
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              textColor: Colors.black.withOpacity(0.5),
              onPressed: () async {
                await this.update();
                Navigator.of(this.context).pop();
              },
            )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                CircleCheckbox(
                  value: this.task.done,
                  onChanged: (bool checked) {
                    this.task.done = checked;
                  },
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: this.editableTitle()
                ),
                ImportantCheckBox(
                  value: this.task.important,
                  onChanged: (bool checked) {
                    this.task.important = checked;
                  },
                )
              ],
            ),
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
  Widget dialogWhenDeleteTask() {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Text('Are you sure delete this task?'),
      actions: <Widget>[
        // Cancel button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () { // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          },
        ),
        // Yes Button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Theme.of(context).errorColor,
          textColor: Colors.white,
          child: const Text('Yes'),
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          },
        ),
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
            return const Center(
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
    List<ItemListTile> tiles = [];

    steps.forEach((step) {
      tiles.add(this.buildItemInListView(step));
    });

    tiles.add(this.buildItemInListView(
      StepModel(id: null, title: '', done: false, taskId: widget.task.id)
    ));

    return Container(
      child: Column(
        children: tiles
      ),
    );
  }

  /// Build a children in listview.
  Widget buildItemInListView(StepModel step) {
    return ItemListTile(
      key: Key(step.id.toString()),
      step: step,
      onChanged: (StepModel step) {
        if (step.title == null) {
          this.bloc.deleteStep(step);
        } else {
          if (step.id == null) {
            this.bloc.addStep(step);
          } else {
            this.bloc.updateStep(step);
          }
        }
      }
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
