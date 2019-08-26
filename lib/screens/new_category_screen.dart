import 'package:flutter/material.dart';
import 'package:tasks/models/category.dart';

class NewCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewCategoryScreenState();
  }
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final controllerTitle = new TextEditingController();
  final controllerDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Category")
      ),
      body: Container(
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title:"
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Enter category title.';
                    }
                    return null;
                  },
                  controller: controllerTitle
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description:"
                  ),
                  controller: controllerDescription
                ),
                RaisedButton(
                  child: Text("New"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Category newCat = new Category(
                        title: controllerTitle.text.trim(),
                        description: controllerDescription.text.trim()
                      );
                      Navigator.of(context).pop(newCat);
                    }
                  }
                )
              ],
            )
          )
        )
      )
    );
  }
}
