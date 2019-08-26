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
                    Category newCat = new Category(
                      title: controllerTitle.text,
                      description: controllerDescription.text
                    );
                    Navigator.of(context).pop(newCat);
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
