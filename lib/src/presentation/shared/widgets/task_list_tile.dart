import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class TaskListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final Color color;

  TaskListTile({this.leading, this.title, this.trailing, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: UIColors.GreyBorder,
            blurRadius: 10.0,
            spreadRadius: 0.5,
            offset: Offset(0.0, 0.0)
          )
        ],
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [this.color, Colors.white]
        )
      ),
      child: ListTile(
        leading: this.leading,
        title: this.title,
        trailing: this.trailing
        
      )
    );
  }
}
