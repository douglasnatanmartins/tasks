import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/blocs/categories_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  /// Create a CategoryListView widget.
  CategoryListView({
    Key key,
  }): super(key: key);

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    CategoriesBloc component = Provider.of(context, component: CategoriesBloc);
    return StreamBuilder(
      stream: component.state,
      initialData: component.categories,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data == CategoriesState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return this._buildContent(component.categories);
      },
    );
  }

  Widget _buildContent(List<CategoryModel> categories) {
    if (categories.length > 0) {
      return PageView.builder(
        controller: PageController(
          viewportFraction: 0.8,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryCard(
            category: categories[index],
          );
        },
      );
    } else {
      return EmptyContentBox(
        message: 'empty categories',
      );
    }
  }
}
