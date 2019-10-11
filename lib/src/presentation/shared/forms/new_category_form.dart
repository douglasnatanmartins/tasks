import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

class NewCategoryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends State<NewCategoryForm> {
  GlobalKey<FormState> _key;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    this._key = GlobalKey<FormState>();
    this._titleController = TextEditingController();
    this._descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    this._titleController.dispose();
    this._descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 450,
        height: 250,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Text(
                'New Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              ),
              TextFormField(
                autofocus: true,
                controller: this._titleController,
                decoration: const InputDecoration(
                  labelText: 'Title'
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Enter category title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: this._descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description'
                )
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    color: Colors.green,
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        CategoryModel category = CategoryModel(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          created: DateTime.now()
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
