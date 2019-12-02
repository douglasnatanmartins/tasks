import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/presentation/pages/category_detail/category_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'categories_controller.dart';

part 'widgets/page_body.dart';
part 'widgets/page_header.dart';
part 'widgets/category_list_view.dart';
part 'widgets/category_card.dart';

class CategoriesPage extends StatelessWidget {
  /// Create a CategoriesPage widget.
  CategoriesPage({
    Key key,
  }): super(key: key);

  /// Build the CategoriesPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<_Shared>(
      creator: (context) {
        return _Shared(
          controller: CategoriesController(),
        );
      },
      disposer: (context, shared) {
        shared.controller.dispose();
      },
      child: this.buildPage(),
    );
  }

  Widget buildPage() {
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
      floatingActionButton: Consumer<_Shared>(
        builder: (context, shared) {
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
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CategoryDetailPage(category: null);
                },
              );

              if (result is CategoryEntity) {
                shared.controller.addCategory(result);
              }
            },
          );
        },
      ),
    );
  }
}

class _Shared {
  _Shared({
    @required this.controller,
  });

  final CategoriesController controller;
}
