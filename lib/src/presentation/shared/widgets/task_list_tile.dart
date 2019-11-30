import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/utils/date_time_util.dart';

import 'icon_checkbox.dart';

class TaskListTile extends StatefulWidget {
  /// Create a TaskListTile widget.
  /// 
  /// The [data] argument must not be null.
  /// 
  /// The [onChanged] argument must not be null.
  TaskListTile({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);
  
  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  TaskEntity data;
  Color metaColor = Color(0xff878787);

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskListTile old) {
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskListTile widget with state.
  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];

    children.add(
      Text(
        this.data.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (this.data.dueDate != null) {
      int days = DateTimeUtil.difference(this.data.dueDate).inDays;
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
              DateFormat('EEEE, y/M/d').format(this.data.dueDate),
              style: TextStyle(
                fontSize: 14.0,
                color: this.metaColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      leading: CircleCheckbox(
        value: this.data.isDone,
        onChanged: (bool checked) {
          this.data = this.data.copyWith(
            isDone: checked,
          );
          this.widget.onChanged(this.data);
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
      trailing: IconCheckbox(
        value: this.data.isImportant,
        icon: Icons.star,
        onChanged: (bool checked) {
          this.data = this.data.copyWith(
            isImportant: checked,
          );
          this.widget.onChanged(this.data);
        },
      ),
    );
  }
}
