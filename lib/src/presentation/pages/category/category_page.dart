import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_controller.dart';

part 'widgets/page_body.dart';
part 'widgets/page_header.dart';
part 'widgets/project_list_view.dart';
part 'widgets/project_card.dart';
part 'widgets/category_delete_dialog.dart';

class CategoryPage extends StatefulWidget {
  /// Create a CategoryPage widget.
  CategoryPage({
    Key key,
    @required this.data,
  })  : super(key: key);

  final CategoryEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryController controller;
  CategoryEntity category;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();

    this.category = this.widget.data;
    this.controller = CategoryController(this.category);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CategoryPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  /// Build the CategoryPage widget with state.
  @override
  Widget build(BuildContext context) {
    return Component<CategoryController>.value(
      value: this.controller,
      child: this.buildPage(),
    );
  }

  Widget buildPage() {
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Column(
              children: <Widget>[
                _PageHeader(data: this.category),
                _PageBody(),
              ],
            ),
          ),
          // Create new project button.
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            heroTag: 'floating-button',
            elevation: 0,
            backgroundColor: Colors.green[600],
            child: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.of(this.context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProjectDetailPage(
                      category: this.category,
                      project: null,
                    );
                  },
                ),
              );

              if (result is ProjectEntity) {
                this.controller.addProject(result);
              }
            },
          ),
        );
      },
    );
  }
}
