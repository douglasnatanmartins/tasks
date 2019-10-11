import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

class ItemListTile extends StatefulWidget {
  final TaskModel task;
  final ValueChanged<bool> onChanged;

  ItemListTile({
    Key key,
    @required this.task,
    @required this.onChanged
  }): assert(task != null),
      assert(onChanged != null),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        leading: CircleCheckbox(
          value: task.done,
          onChanged: this.widget.onChanged
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.task.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600
              )
            ),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(Icons.date_range, size: 18.0),
                SizedBox(width: 5.0),
                Text(
                  DateFormat.yMEd().format(this.task.dueDate)
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/task', arguments: task);
        }
      )
    );
  }
}
