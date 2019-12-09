import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/color_picker.dart';
import 'package:tasks/src/presentation/shared/pickers/icon_picker/icon_picker.dart';
import 'package:tasks/src/utils/data_support.dart';

part 'sections/page_body.dart';
part 'sections/description_text_field.dart';
part 'sections/icon_field.dart';
part 'sections/title_text_field.dart';
part 'sections/page_header.dart';
part 'sections/action_buttons.dart';

class ProjectDetailPage extends StatefulWidget {
  /// Create a ProjectDetailPage widget.
  ProjectDetailPage({
    Key key,
    @required this.category,
    @required this.project,
  })  : assert(category != null || project != null),
        super(key: key);

  final CategoryEntity category;
  final ProjectEntity project;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ProjectEntity project;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    if (this.widget.project != null) {
      this.project = this.widget.project;
    } else {
      this.project = ProjectEntity(
        id: null,
        categoryId: this.widget.category.id,
        title: '',
        description: null,
        color: DataSupport.colors.values.elementAt(0),
        icon: DataSupport.icons.values.elementAt(0),
        createdDate: DateTime.now(),
      );
    }
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(ProjectDetailPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Set project with new properties.
  void setProject(ProjectEntity data) {
    setState(() {
      this.project = data;
    });
  }

  /// Build the ProjectDetailPage widget with state.
  @override
  Widget build(BuildContext context) {
    return this.buildPage();
  }

  Widget buildPage() {
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              _PageHeader(data: this.project),
              _PageBody(
                project: this.project,
                onChanged: this.setProject,
              ),
            ],
          ),
        );
      },
    );
  }
}
