import 'package:flutter/material.dart';
import 'project_card.dart';

class ProjectListView extends StatelessWidget {
  /// Create a ProjectListView widget.
  ProjectListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<Map<String, dynamic>> items;

  /// Build the ProjectListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = this.items.elementAt(index);
        return ProjectCard(
          model: item['project'],
          progress: item['progress'],
        );
      },
    );
  }
}
