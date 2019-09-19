import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  ProjectCard({this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            project.title,
            style: TextStyle(
              color: UIColors.Purple,
              fontSize: 17.0,
              fontWeight: FontWeight.w600
            )
          ),
          SizedBox(height: 5.0),
          Text(
            project.description,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8)
            )
          )
        ]
      )
    );
  }
}
