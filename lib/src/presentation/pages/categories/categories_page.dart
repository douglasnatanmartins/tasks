import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/blocs/categories_bloc.dart';
import 'package:tasks/src/presentation/pages/categories/widgets/category_list_view.dart';
import 'package:tasks/src/presentation/shared/forms/new_category_form.dart';

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
            this.pageHeader(),
            this.pageBody(),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (BuildContext context, Map<Type, dynamic> components) {
          CategoriesBloc bloc = components[CategoriesBloc];
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
                  return NewCategoryForm();
                }
              );

              if (result is CategoryModel) {
                bloc.addCategory(result);
              }
            },
          );
        },
        requires: [
          CategoriesBloc,
        ],
      ),
    );
  }

  /// Build header this page.
  Widget pageHeader() {
    final DateTime now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 140.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat.EEEE().format(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                '${DateFormat.d().format(now)} ${DateFormat.MMMM().format(now)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Consumer(
                builder: (BuildContext context, Map<Type, dynamic> components) {
                  CategoriesBloc bloc = components[CategoriesBloc];
                  return StreamBuilder(
                    stream: bloc.state,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      String description = '...';
                      final data = bloc.categories;
                      if (data.isEmpty) {
                        description = 'You not have category';
                      } else if (data.length == 1) {
                        description = 'You have 1 category';
                      } else {
                        description = 'You have ${data.length} categories';
                      }
                      return Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 18.0,
                        ),
                      );
                    },
                  );
                },
                requires: [
                  CategoriesBloc,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build body this page.
  Widget pageBody() {
    return Expanded(
      child: CategoryListView(),
    );
  }
}
