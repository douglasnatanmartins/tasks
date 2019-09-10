import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

class NewCategoryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewCategoryFormState();
  }
}

class _NewCategoryFormState extends State<NewCategoryForm> {
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
        padding: EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Text(
                "New Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              ),
              Flexible(
                child: TextFormField(
                  autofocus: true,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title"
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter category title.";
                    }
                    return null;
                  },
                )
              ),
              Flexible(
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description"
                  )
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
                        CategoryModel category = CategoryModel(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim()
                        );
                        Navigator.of(context).pop(category);
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
