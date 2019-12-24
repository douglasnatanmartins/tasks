part of '../task_layout.dart';

class PageFooter extends StatelessWidget {
  /// Build the PageFooter widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);
    var task = controller.task;

    return Column(
      children: <Widget>[
        DatePicker(
          title: 'Add due date',
          icon: Icons.date_range,
          initialDate: task.dueDate,
          onChanged: (date) {
            controller.setTaskDueDate(date);
          },
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          padding: const EdgeInsets.all(10),
          child: TextField(
            autocorrect: false,
            controller: TextEditingController(text: controller.task.note),
            decoration: const InputDecoration.collapsed(
              hintText: 'Note',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            onChanged: (note) {
              controller.setTaskNote(note);
            },
          )
        ),
      ],
    );
  }
}
