import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

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
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
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
    controller.dispose();
    super.dispose();
  }

  /// Build the TaskNewForm widget with state.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'New Task',
        style: Theme.of(context).textTheme.headline,
      ),
      content: Form(
        key: key,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          autofocus: true,
          controller: controller,
          validator: (value) {
            if (value.trim().isEmpty) {
              return 'Enter this task title.';
            }

            return null;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () {
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Add'),
          onPressed: () {
            // The task title is valid.
            if (key.currentState.validate()) {
              var task = TaskEntity(
                id: null,
                projectId: widget.project,
                title: controller.text.trim(),
                note: null,
                isDone: false,
                isImportant: false,
                dueDate: null,
                createdDate: DateTime.now(),
              );
              Navigator.of(context).pop(task);
            }
          },
        ),
      ],
    );
  }
}
