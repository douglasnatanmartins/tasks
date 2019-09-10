import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

class NewTaskForm extends StatefulWidget {
  final int projectId;

  NewTaskForm({@required this.projectId});

  @override
  State<StatefulWidget> createState() {
    return _NewTaskFormState();
  }
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _key = GlobalKey<FormState>();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Task"),
      content: Form(
        key: _key,
        child: TextFormField(
          autofocus: true,
          controller: _controller,
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please enter task title";
            }
            return null;
          }
        )
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            _controller.clear();
            Navigator.pop(context);
          }
        ),
        FlatButton(
          color: Colors.green,
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () {
            if (_key.currentState.validate()) {
              final task = TaskModel(
                title: _controller.value.text.trim(),
                done: false,
                projectId: widget.projectId
              );
              Navigator.of(context).pop(task);
            }
          }
        )
      ],
    );
  }
}
