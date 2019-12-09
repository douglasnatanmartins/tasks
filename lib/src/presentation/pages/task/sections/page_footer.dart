part of '../task_layout.dart';

class _PageFooter extends StatelessWidget {
  /// Create a _PageFooter widget.
  _PageFooter({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Build the _PageFooter widget.
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
        _TaskNoteTextField(
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
