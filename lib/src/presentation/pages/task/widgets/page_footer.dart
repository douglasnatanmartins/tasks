import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';

import 'task_note_text_field.dart';

class PageFooter extends StatelessWidget {
  /// Create a PageFooter widget.
  PageFooter({
    Key key,
    @required this.model,
  }): super(key: key);

  final TaskModel model;

  /// Build the PageFooter widget.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DatePicker(
          title: 'Add due date',
          icon: Icons.date_range,
          initialDate: this.model.dueDate,
          onChanged: (DateTime date) {
            this.model.dueDate = date;
          },
        ),
        TaskNoteTextField(
          data: this.model.note,
          onChanged: (String note) {
            this.model.note = note;
          },
        ),
      ],
    );
  }
}
