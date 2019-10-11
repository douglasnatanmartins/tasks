import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'item_list_tile.dart';

class GroupListTile extends StatefulWidget {
  final String title;
  final List<TaskModel> items;
  final ValueChanged<TaskModel> onChanged;

  GroupListTile({
    Key key,
    @required this.title,
    @required this.items,
    @required this.onChanged
  }): assert(title != null),
      assert(items != null),
      assert(onChanged != null),
      super(key: key);

  @override
  State<GroupListTile> createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  String title;
  List<TaskModel> items;

  @override
  void initState() {
    super.initState();
    this.title = this.widget.title;
    this.items = this.widget.items;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(this.title),
      children: this.buildChildren()
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = <Widget>[];
    this.items.forEach((TaskModel task) {
      children.add(ItemListTile(
        task: task,
        onChanged: (bool checked) {
          task.done = checked;
          this.widget.onChanged(task);
        }
      ));
    });

    return children;
  }
}
