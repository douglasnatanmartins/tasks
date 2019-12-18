import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';
import 'package:tasks/src/presentation/pages/category_detail/category_detail_page.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/project_list_view.dart';
part 'sections/project_card.dart';
part 'sections/category_delete_dialog.dart';

class CategoryLayout extends StatelessWidget {
  /// Create a CategoryLayout widget.
  CategoryLayout({
    Key key,
    @required this.category,
  }): super(key: key);

  final CategoryEntity category;

  /// Build the CategoryLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _PageHeader(data: category),
            _PageBody(),
          ],
        ),
      ),
      // Create new project button.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<CategoryController>(
        builder: (context, controller) {
          return FloatingActionButton(
            heroTag: 'floating-button',
            elevation: 0,
            backgroundColor: Colors.green[600],
            child: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProjectDetailPage(
                      category: category,
                      project: null,
                    );
                  },
                ),
              );

              if (result is ProjectEntity) {
                controller.createProject(result);
              }
            },
          );
        },
      ),
    );
  }
}
