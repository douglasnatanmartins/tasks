import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';

import 'task_note_text_field.dart';

class PageFooter extends StatelessWidget {
  /// Create a PageFooter widget.
  PageFooter({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Build the PageFooter widget.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DatePicker(
          title: 'Add due date',
          icon: Icons.date_range,
          initialDate: this.data.dueDate,
          onChanged: (DateTime date) {
            this.onChanged(this.data.copyWith(
              dueDate: date,
            ));
          },
        ),
        TaskNoteTextField(
          data: this.data.note,
          onChanged: (String note) {
            this.onChanged(this.data.copyWith(
              note: note,
            ));
          },
        ),
      ],
    );
  }
}
