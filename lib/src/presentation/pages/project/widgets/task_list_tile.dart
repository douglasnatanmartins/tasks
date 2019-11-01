import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

class TaskListTile extends StatefulWidget {
  TaskListTile({
    Key key,
    @required this.task,
    @required this.onChanged,
    @required this.whenOpened
  }): assert(task != null),
      assert(onChanged != null),
      assert(whenOpened != null),
      super(key: key);

  final TaskModel task;
  final ValueChanged<TaskModel> onChanged;
  final Function whenOpened;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  TaskModel task;
  TextDecoration decoration;

  @override
  void initState() {
    super.initState();
    this.decoration = TextDecoration.none;
    this.task = this.widget.task;
  }

  @override
  void didUpdateWidget(TaskListTile oldWidget) {
    if (oldWidget.task != this.widget.task) {
      this.task = this.widget.task;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.task.done) {
      this.decoration = TextDecoration.lineThrough;
    } else {
      this.decoration = TextDecoration.none;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: this.task.done,
        onChanged: (bool checked) {
          setState(() {
            this.task.done = checked;
            this.widget.onChanged(this.task);
          });
        }
      ),
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: decoration,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: task.important ? Colors.yellow.shade600 : null,
        ),
        onPressed: () {
          setState(() {
            this.task.important = !task.important;
            this.widget.onChanged(this.task);
          });
        },
      ),
      onTap: () { // Open a task page.
        Navigator.of(this.context).pushNamed('/task', arguments: task)
          .then((result) => this.widget.whenOpened());
      },
    );
  }
}
