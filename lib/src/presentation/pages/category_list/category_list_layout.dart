import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/presentation/pages/category_detail/category_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_list_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/category_list_view.dart';
part 'sections/category_card.dart';

class CategoryListLayout extends StatelessWidget {
  /// Create a CategoryListLayout widget.
  CategoryListLayout({
    Key key,
  }): super(key: key);

  /// Build the CategoryListLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _PageHeader(),
            _PageBody(),
          ],
        ),
      ),
      floatingActionButton: Consumer<CategoryListController>(
        builder: (context, controller) {
          return FloatingActionButton(
            heroTag: 'floating-button',
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white.withOpacity(0.85),
                width: 3.0,
              ),
            ),
            elevation: 0,
            child: const Icon(Icons.add, size: 30),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onPressed: () async {
              var result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CategoryDetailPage(category: null);
                },
              );

              if (result is CategoryEntity) {
                controller.createCategory(result);
              }
            },
          );
        },
      ),
    );
  }
}
