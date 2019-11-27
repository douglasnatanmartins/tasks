import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page.dart';

import '../categories_controller.dart';

class CategoryCard extends StatelessWidget {
  /// Create a CategoryCard widget.
  /// 
  /// The [category] argument must not be null.
  CategoryCard({
    Key key,
    @required this.category,
  }): assert(category != null),
      super(key: key);

  final CategoryModel category;

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(
                flex: 5,
              ),
              Text(
                category.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                category.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 28.0,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        final component = Component.of<CategoriesController>(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Component<CategoriesController>.value(
                value: component,
                child: CategoryPage(category: this.category),
              );
            },
          ),
        );
      },
    );
  }
}
