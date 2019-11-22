import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/step_model.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/blocs/tasks_bloc.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import 'task_page_bloc.dart';
import 'widgets/step_list_tile.dart';
import 'widgets/task_note_text_field.dart';
import 'widgets/task_title_text_field.dart';
import 'widgets/important_checkbox.dart';
import 'widgets/task_delete_dialog.dart';

class TaskPage extends StatefulWidget {
  /// Create a TaskPage widget.
  /// 
  /// The [data] argument must not be null.
  TaskPage({
    Key key,
    @required this.data,
  }): super(key: key);

  final TaskModel data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskPageBloc bloc;
  TaskModel data;
  String title;
  List<StepModel> steps;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.title = this.data.title;
    this.bloc = TaskPageBloc(this.data);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskPage widget with this state.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final TasksBloc bloc = Provider.of(context, component: TasksBloc);
        await bloc.updateTask(this.data);
        return true;
      },
      child: Scaffold(
        body: this.buildPage(),
        backgroundColor: Colors.grey[200],
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Created on ${DateFormat.yMMMd().format(this.data.createdDate)}',
                  style: Theme.of(this.context).textTheme.subtitle.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Consumer(
                  requires: [TasksBloc],
                  builder: (context, components) {
                    final component = components[TasksBloc];
                    return IconButton(
                      color: Colors.red[400],
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TaskDeleteDialog();
                          },
                        );

                        if (result != null && result) {
                          if (await component.deleteTask(this.data)) {
                            Navigator.of(this.context).pop();
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
              this.footerPage(),
            ],
          ),
        ),
      ),
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
                Navigator.of(this.context).maybePop();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                CircleCheckbox(
                  value: this.data.done,
                  onChanged: (bool checked) {
                    this.data.done = checked;
                  },
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TaskTitleTextField(
                    data: this.data.title,
                    onChanged: (String newTitle) {
                      this.title = newTitle;
                    },
                  ),
                ),
                ImportantCheckBox(
                  value: this.data.important,
                  onChanged: (bool checked) {
                    this.data.important = checked;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build main content this page.
  Widget bodyPage() {
    return Expanded(
      child: StreamBuilder(
        stream: this.bloc.steps,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            return this.buildListView(snapshot.data);
          }
        },
      ),
    );
  }

  /// Build a listview to show steps of task.
  Widget buildListView(List<StepModel> steps) {
    List<StepListTile> tiles = [];

    steps.forEach((step) {
      tiles.add(this.buildItemInListView(step));
    });

    tiles.add(this.buildItemInListView(
      StepModel(id: null, title: '', done: false, taskId: widget.data.id)
    ));

    return Container(
      child: Column(
        children: tiles,
      ),
    );
  }

  /// Build a children in listview.
  Widget buildItemInListView(StepModel step) {
    return StepListTile(
      key: Key(step.id.toString()),
      data: step,
      onChanged: (StepModel newModel) {
        if (step.title == null) {
          this.bloc.deleteStep(step);
        } else {
          if (step.id == null) {
            this.bloc.addStep(step);
          } else {
            this.bloc.updateStep(step, newModel);
          }
        }
      },
    );
  }

  /// Build footer this page.
  Widget footerPage() {
    return Column(
      children: <Widget>[
        DatePicker(
          title: 'Add due date',
          icon: Icons.date_range,
          initialDate: this.data.dueDate,
          onChanged: (DateTime date) {
            this.data.dueDate = date;
          },
        ),
        TaskNoteTextField(
          data: this.data.note,
          onChanged: (String note) {
            this.data.note = note;
          },
        ),
      ],
    );
  }
}
