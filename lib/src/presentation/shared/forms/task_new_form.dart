import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

class TaskNewForm extends StatefulWidget {
  /// Create a TaskNewForm widget.
  /// 
  /// The [project] argument must not be null and greater than or equal zero.
  /// The `project` argument is the project id.
  TaskNewForm({
    Key key,
    @required this.project,
  }): assert(project != null),
      assert(project >= 0),
      super(key: key);

  final int project;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskNewForm> createState() => _TaskNewFormState();
}

class _TaskNewFormState extends State<TaskNewForm> {
  GlobalKey<FormState> key;
  TextEditingController controller;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.key = GlobalKey<FormState>();
    this.controller = TextEditingController();
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskNewForm old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskNewForm widget with state.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        'New Task',
        style: Theme.of(context).textTheme.headline,
      ),
      content: Form(
        key: this.key,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          autofocus: true,
          controller: this.controller,
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Enter this task title.';
            }

            return null;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () {
            this.controller.clear();
            Navigator.of(this.context).pop();
          },
        ),
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Add'),
          onPressed: () {
            if (this.key.currentState.validate()) {
              final task = TaskModel(
                title: this.controller.text.trim(),
                done: false,
                projectId: this.widget.project,
                important: false,
                createdDate: DateTime.now(),
              );
              Navigator.of(this.context).pop(task);
            }
          },
        ),
      ],
    );
  }
}
