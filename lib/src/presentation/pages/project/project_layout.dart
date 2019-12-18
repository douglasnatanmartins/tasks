import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/project_manager_contract.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/forms/task_new_form.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'project_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/task_list_tile.dart';
part 'sections/task_list_view.dart';

class ProjectLayout extends StatelessWidget {
  /// Create a ProjectLayout widget.
  ProjectLayout({
    Key key,
    @required this.data,
  }): super(key: key);

  final ProjectEntity data;

  /// Build the ProjectLayout widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectController>(context);

    return Scaffold(
      backgroundColor: data.color,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _PageHeader(data: data),
            _PageBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () async {
          var result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return TaskNewForm(project: data.id);
            },
          );

          if (result is TaskEntity) {
            controller.createTask(result);
          }
        },
      ),
    );
  }
}
