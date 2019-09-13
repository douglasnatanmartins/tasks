import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class BoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BoardPageState();
  }
}

class _BoardPageState extends State<BoardPage> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return TaskListTile(
            color: UIColors.Orange,
            leading: Checkbox(
              value: _value,
              onChanged: (checked) {
                setState(() {
                  _value = checked;
                });
              },
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: UIColors.TextHeader,
                fontWeight: FontWeight.w600
              )
            ),
          );
        }
      )
    );
  }
}
