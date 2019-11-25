import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/blocs/categories_bloc.dart';
import 'package:tasks/src/presentation/pages/categories/widgets/category_list_view.dart';
import 'package:tasks/src/presentation/shared/forms/category_new_form.dart';

import 'widgets/page_body.dart';
import 'widgets/page_header.dart';

class CategoriesPage extends StatelessWidget {
  /// Create a CategoriesPage widget.
  CategoriesPage({
    Key key,
  }): super(key: key);

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return this.buildPage(context);
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(),
            PageBody(),
          ],
        ),
      ),
      floatingActionButton: Consumer<CategoriesBloc>(
        builder: (context, component) {
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
                  return CategoryNewForm();
                }
              );

              if (result is CategoryModel) {
                component.addCategory(result);
              }
            },
          );
        },
      ),
    );
  }
}
