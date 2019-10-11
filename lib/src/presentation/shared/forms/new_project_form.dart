import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/color_picker.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class NewProjectForm extends StatefulWidget {
  final int categoryId;

  NewProjectForm({
    Key key,
    @required this.categoryId
  }): assert(categoryId != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  GlobalKey<FormState> key;
  TextEditingController titleController;
  TextEditingController descriptionController;
  Color colorProject;

  @override
  void initState() {
    super.initState();
    key = GlobalKey<FormState>();
    this.titleController = TextEditingController();
    this.descriptionController = TextEditingController();
    this.colorProject = Colors.grey[400];
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        height: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
              child: Text(
                'Add new project',
                style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 16.0
                )
              )
            ),
            const SizedBox(height: 30.0),
            this.buildForm(),
            const SizedBox(height: 20.0),
            ColorPicker(
              colors: const <Color>[
                UIColors.Blue,
                UIColors.Green,
                UIColors.Orange,
                UIColors.Red,
                UIColors.Purple
              ],
              onChanged: (Color selected) {
                this.colorProject = selected;
              },
            ),
            Spacer(),
            this.buildActions(),
          ]
        )
      )
    );
  }

  Widget buildForm() {
    return Form(
      key: this.key,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(12.0),
                    color: Colors.grey.withOpacity(0.2),
                    child: Icon(Icons.folder),
                    onPressed: () {}
                  )
                ),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: this.titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title'
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Enter this project title.';
                      }
                      return null;
                    },
                  )
                )
              ]
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: this.descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description'
                )
            )
          ]
        )
      )
    );
  }

  Widget buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          color: Colors.green,
          child: Text(
            'Create',
            style: TextStyle(
              color: Colors.white
            )
          ),
          onPressed: () {
            if (this.key.currentState.validate()) {
              final ProjectModel project = ProjectModel(
                title: this.titleController.text.trim(),
                description: this.descriptionController.text.trim(),
                categoryId: this.widget.categoryId,
                created: DateTime.now(),
                color: this.colorProject,
              );
              Navigator.of(context).pop(project);
            }
          }
        )
      ]
    );
  }
}
