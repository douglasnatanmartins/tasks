import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import '../planned_controller.dart';
import 'task_list_view.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
  }): super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<PlannedController>(context);
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: component.tasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return TaskListView(
                  items: snapshot.data,
                );
              } else {
                return EmptyContentBox(
                  title: 'no planned task created yet',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
