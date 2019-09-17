import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  CategoryCard({this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      elevation: 5.0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(
              flex: 5
            ),
            Text(
              category.description,
              style: TextStyle(
                color: UIColors.TextSubHeader
              )
            ),
            SizedBox(height: 5),
            Text(
              category.title,
              style: TextStyle(
                color: UIColors.TextHeader,
                fontSize: 28.0
              )
            )
          ]
        )
      )
    );
  }
}
