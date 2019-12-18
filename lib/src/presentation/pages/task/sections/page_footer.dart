part of '../task_layout.dart';

class _PageFooter extends StatelessWidget {
  /// Create a PageFooter widget.
  _PageFooter({
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
          initialDate: data.dueDate,
          onChanged: (date) {
            onChanged(data.copyWith(
              dueDate: date,
            ));
          },
        ),
        _TaskNoteTextField(
          data: data.note,
          onChanged: (note) {
            onChanged(data.copyWith(
              note: note,
            ));
          },
        ),
      ],
    );
  }
}
