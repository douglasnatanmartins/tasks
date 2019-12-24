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
    data = widget.data;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskListTile old) {
    if (old.data != widget.data) {
      data = widget.data;
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
        data.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (data.dueDate != null) {
      int days = DateTimeUtil.difference(data.dueDate).inDays;
      metaColor = days >= 0 ? Colors.blue : Colors.red;
      children.add(const SizedBox(height: 5));
      children.add(
        Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              size: 16,
              color: metaColor,
            ),
            const SizedBox(width: 4.5),
            Text(
              DateFormat('EEEE, y/M/d').format(data.dueDate),
              style: TextStyle(
                fontSize: 14,
                color: metaColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      leading: CircleCheckbox(
        value: data.isDone,
        onChanged: (bool checked) {
          data = data.copyWith(
            isDone: checked,
          );

          widget.onChanged(data);
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
      trailing: IconCheckbox(
        value: data.isImportant,
        icon: Icons.star,
        onChanged: (bool checked) {
          data = data.copyWith(
            isImportant: checked,
          );
          widget.onChanged(data);
        },
      ),
    );
  }
}
