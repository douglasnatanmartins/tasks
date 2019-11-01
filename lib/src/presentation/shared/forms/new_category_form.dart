import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

class NewCategoryForm extends StatefulWidget {
  NewCategoryForm({
    Key key
  }): super(key: key);

  @override
  State<NewCategoryForm> createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends State<NewCategoryForm> {
  GlobalKey<FormState> key;
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    this.key = GlobalKey<FormState>();
    this.titleController = TextEditingController();
    this.descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    this.titleController.dispose();
    this.descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: this.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'New Category',
                style: Theme.of(context).textTheme.headline,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                autofocus: true,
                controller: this.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Enter category title';
                  }
                  return null;
                },
                maxLength: 255,
              ),
              TextFormField(
                controller: this.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    textColor: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                    child: const Text('Create'),
                    onPressed: () {
                      if (this.key.currentState.validate()) {
                        CategoryModel category = CategoryModel(
                          title: this.titleController.text.trim(),
                          description: this.descriptionController.text.trim(),
                          created: DateTime.now(),
                        );
                        Navigator.of(context).pop(category);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
