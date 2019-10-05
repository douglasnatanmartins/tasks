import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class NewTaskForm extends StatefulWidget {
  final int projectId;

  NewTaskForm({
    Key key,
    @required this.projectId
  }): assert(projectId != null), super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'New Task',
        style: UIColors.TextHeader
      ),
      content: Form(
        key: this.key,
        child: TextFormField(
          autofocus: true,
          controller: this._controller,
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
            this._controller.clear();
            Navigator.of(context).pop();
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
                title: _controller.value.text.trim(),
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
