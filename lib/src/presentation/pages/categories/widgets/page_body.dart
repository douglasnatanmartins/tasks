import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import '../categories_controller.dart';
import 'category_list_view.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
  }): super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<CategoriesController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.categories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return CategoryListView(
                items: snapshot.data,
              );
            } else {
              return EmptyContentBox(
                title: 'not category created yet',
                description: 'click the add button to get started',
              );
            }
          }
        },
      ),
    );
  }
}
