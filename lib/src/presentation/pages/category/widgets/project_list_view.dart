import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/pages/project/project_page.dart';

import '../category_controller.dart';
import 'project_card.dart';

class ProjectListView extends StatefulWidget {
  ProjectListView({
    Key key,
    @required this.data,
  }): assert(data != null),
      super(key: key);

  final List<Map<String, dynamic>> data;

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
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
      itemCount: this.data.length,
      itemBuilder: (BuildContext context, int index) {
        final project = this.data[index];
        return this.buildItem(project['project'], project['progress']);
      },
    );
  }

  Widget buildItem(ProjectModel project, double progress) {
    return GestureDetector(
      child: ProjectCard(
        project: project,
        progress: progress,
      ),
      onTap: () {
        final component = Component.of<CategoryController>(context);
        Navigator.of(this.context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Component<CategoryController>.value(
                value: component,
                child: ProjectPage(model: project),
              );
            }
          ),
        );
      },
    );
  }
}
