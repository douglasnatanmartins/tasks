import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/utils/date_time_util.dart';

import 'icon_checkbox.dart';

class TaskListTile extends StatefulWidget {
  TaskListTile({
    Key key,
    @required this.task,
    @required this.onChanged,
  }): assert(task != null),
      assert(onChanged != null),
      super(key: key);

  final TaskModel task;
  final ValueChanged<TaskModel> onChanged;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  Color metaColor = Color(0xff878787);
  TaskModel task;

  @override
  void initState() {
    super.initState();
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
    List<Widget> children = <Widget>[];

    children.add(
      Text(
        this.task.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (this.task.dueDate != null) {
      int days = DateTimeUtil.difference(this.task.dueDate).inDays;
      this.metaColor = days >= 0 ? Colors.blue : Colors.red;
      children.add(const SizedBox(height: 5.0));
      children.add(
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              size: 16.0,
              color: this.metaColor,
            ),
            const SizedBox(width: 4.5),
            Text(
              DateFormat('EEEE, y/M/d').format(this.task.dueDate),
              style: TextStyle(
                fontSize: 14.0,
                color: this.metaColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(0.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 5.0,
        ),
        leading: CircleCheckbox(
          value: task.done,
          onChanged: (bool checked) {
            this.task.done = checked;
            this.widget.onChanged(task);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
        trailing: IconCheckbox(
          value: this.task.important,
          icon: Icons.star,
          onChanged: (bool checked) {
            this.task.important = checked;
            this.widget.onChanged(this.task);
          },
        ),
        onTap: () {
          Navigator.of(this.context).pushNamed('/task', arguments: this.task);
        },
      ),
    );
  }
}
