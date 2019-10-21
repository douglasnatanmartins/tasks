import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

class ItemListTile extends StatefulWidget {
  ItemListTile({
    Key key,
    @required this.task,
    @required this.onChanged,
    @required this.whenOnTap
  }): assert(task != null),
      assert(onChanged != null),
      assert(whenOnTap != null),
      super(key: key);

  final TaskModel task;
  final ValueChanged<TaskModel> onChanged;
  final Function whenOnTap;

  @override
  State<ItemListTile> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {
  TaskModel task;

  @override
  void initState() {
    super.initState();
    this.task = this.widget.task;
  }

  @override
  void didUpdateWidget(ItemListTile oldWidget) {
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
          fontWeight: FontWeight.w600
        )
      )
    );

    if (this.task.dueDate != null) {
      children.add(const SizedBox(height: 5.0));
      children.add(
        Row(
          children: <Widget>[
            const Icon(Icons.date_range, size: 18.0),
            const SizedBox(width: 5.0),
            Text(
              DateFormat.yMEd().format(this.task.dueDate)
            )
          ],
        )
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
        trailing: IconButton(
          icon: Icon(
            Icons.star,
            color: Colors.yellow[600]
          ),
          onPressed: () {
            this.task.important = !this.task.important;
            this.widget.onChanged(this.task);
          }
        ),
        onTap: () {
          Navigator.of(this.context).pushNamed('/task', arguments: this.task)
            .then((result) => this.widget.whenOnTap());
        },
      ),
    );
  }
}
