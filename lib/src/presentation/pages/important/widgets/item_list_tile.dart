import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

class ItemListTile extends StatefulWidget {
  final TaskModel task;
  final ValueChanged<bool> onChecked;
  final ValueChanged<bool> onImportanted;

  ItemListTile({
    Key key,
    @required this.task,
    @required this.onChecked,
    @required this.onImportanted
  }): assert(task != null),
      assert(onChecked != null),
      super(key: key);

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
    children.add(const SizedBox(height: 5.0));

    if (task.dueDate != null) {
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
          onChanged: this.widget.onChecked
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
            task.important = !task.important;
            this.widget.onImportanted(task.important);
          }
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/task', arguments: task);
        }
      )
    );
  }
}
