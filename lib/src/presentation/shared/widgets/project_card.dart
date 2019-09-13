import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  ProjectCard({this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: UIColors.GreyBorder,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 1.0)
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            project.title,
            style: TextStyle(
              color: UIColors.TextHeader,
              fontSize: 18.0,
              fontWeight: FontWeight.w600
            )
          ),
          Text(
            '24 Tasks'
          )
        ]
      )
    );
  }
}
