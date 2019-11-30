import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'project_card.dart';

class ProjectListView extends StatelessWidget {
  /// Create a ProjectListView widget.
  ProjectListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<ProjectEntity> items;

  /// Build the ProjectListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        return ProjectCard(
          model: this.items.elementAt(index),
        );
      },
    );
  }
}
