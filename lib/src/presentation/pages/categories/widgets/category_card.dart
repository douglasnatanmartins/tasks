import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key key,
    @required this.category
  }): assert(category != null),
      super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
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
    );
  }
}
