import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';

import 'project_card.dart';

class ProjectListView extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final Function whenOpened;

  ProjectListView({
    Key key,
    @required this.data,
    @required this.whenOpened
  }): assert(data != null),
      assert(whenOpened != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  @override
  void didUpdateWidget(ProjectListView oldWidget) {
    if (oldWidget.data != this.widget.data) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final project = data[index];
        return this.buildItem(project['project'], project['progress']);
      }
    );
  }

  Widget buildItem(ProjectModel project, double progress) {
    return GestureDetector(
      child: ProjectCard(
        project: project,
        progress: progress,
      ),
      onTap: () {
        Navigator.of(this.context).pushNamed('/project', arguments: project)
          .then((result) => this.widget.whenOpened());
      }
    );
  }
}
