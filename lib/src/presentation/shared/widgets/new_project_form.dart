import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';

class NewProjectForm extends StatefulWidget {
  final int categoryId;

  NewProjectForm(this.categoryId);

  @override
  State<StatefulWidget> createState() {
    return _NewProjectFormState();
  }
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _key = GlobalKey<FormState>();
  final _titleController = new TextEditingController();
  final _descriptionController = new TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 360,
        height: 280,
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "New List",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              ),
              TextFormField(
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title"
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Please enter project title.";
                  }
                  return null;
                },
              ),
              TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description"
                  )
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    color: Colors.green,
                    child: Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        ProjectModel project = ProjectModel(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          categoryId: widget.categoryId
                        );
                        Navigator.of(context).pop(project);
                      }
                    }
                  )
                )
              )
            ],
          )
        )
      )
    );
  }
}
