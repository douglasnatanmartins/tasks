import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

class NewTaskForm extends StatefulWidget {
  NewTaskForm({
    Key key,
    @required this.project
  }): assert(project != null),
      super(key: key);

  final int project;

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  GlobalKey<FormState> key;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    this.key = GlobalKey<FormState>();
    this.controller = TextEditingController();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

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
