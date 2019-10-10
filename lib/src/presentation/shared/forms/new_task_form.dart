import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

class NewTaskForm extends StatefulWidget {
  final int projectId;

  const NewTaskForm({
    Key key,
    @required this.projectId
  }): assert(projectId != null),
      super(key: key);

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
        borderRadius: BorderRadius.circular(10.0)
      ),
      title: Text(
        'New Task',
        style: Theme.of(context).textTheme.headline
      ),
      content: Form(
        key: this.key,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Title'
          ),
          autofocus: true,
          controller: this.controller,
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Enter this task title.';
            }

            return null;
          }
        )
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            this.controller.clear();
            Navigator.of(this.context).pop();
          }
        ),
        FlatButton(
          color: Colors.green,
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () {
            if (this.key.currentState.validate()) {
              final task = TaskModel(
                title: this.controller.text.trim(),
                done: false,
                projectId: this.widget.projectId,
                important: false,
                createdDate: DateTime.now(),
              );
              Navigator.of(this.context).pop(task);
            }
          }
        )
      ],
    );
  }
}
