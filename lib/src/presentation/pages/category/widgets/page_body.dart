import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import '../category_controller.dart';
import 'project_list_view.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
  }): super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<CategoryController>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: component.projects,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) { // Has the stream data.
                return ProjectListView(items: snapshot.data);
              } else {
                return EmptyContentBox(
                  title: 'no project created yet',
                  description: 'click green button to get started',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
