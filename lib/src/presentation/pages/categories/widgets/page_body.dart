import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/blocs/categories_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_list_view.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
  }): super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<CategoriesBloc>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.state,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data == CategoriesState.Loading) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (component.categories.isNotEmpty) {
            return CategoryListView(
              items: component.categories
            );
          } else {
            return EmptyContentBox(
              title: 'not category created yet',
              description: 'click the add button to get started',
            );
          }
        },
      ),
    );
  }
}
