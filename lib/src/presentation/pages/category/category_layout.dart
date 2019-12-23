import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/pages/category_detail/category_detail_page.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_controller.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';
part 'sections/project_list_view.dart';
part 'sections/project_card.dart';
part 'sections/category_delete_dialog.dart';
part 'sections/header_title.dart';
part 'sections/setting_popup_button.dart';

class CategoryLayout extends StatelessWidget {
  /// Create a CategoryLayout widget.
  CategoryLayout({
    Key key,
  }): super(key: key);

  /// Build the CategoryLayout widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(),
            PageBody(),
          ],
        ),
      ),
      // Create new project button.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        elevation: 0,
        heroTag: 'floating-button',
        onPressed: () async {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProjectDetailPage(categoryId: controller.category.id);
              },
            ),
          );

          if (result is ProjectEntity) {
            controller.createProject(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
