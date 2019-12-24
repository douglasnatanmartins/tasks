import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';

import 'important_task_list_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/task_list_view.dart';

class ImportantTaskListLayout extends StatelessWidget {
  /// Create a ImportantTaskListLayout widget.
  ImportantTaskListLayout({
    Key key,
  }): super(key: key);

  /// Build the ImportantTaskListLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _PageHeader(),
            _PageBody(),
          ],
        ),
      ),
    );
  }
}
