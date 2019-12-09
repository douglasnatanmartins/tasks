import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';
import 'package:tasks/src/utils/date_time_util.dart';

import 'planned_task_list_controller.dart';

part 'sections/group_list_tile.dart';
part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/task_list_view.dart';

class PlannedTaskListLayout extends StatelessWidget {
  /// Create a PlannedTaskListLayout widget.
  PlannedTaskListLayout({
    Key key,
  }): super(key: key);

  /// Build the PlannedTaskListLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(),
            PageBody(),
          ],
        ),
      ),
    );
  }
}
