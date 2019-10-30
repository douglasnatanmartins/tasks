import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/categories/widgets/category_list_view.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/new_category_form.dart';
import 'package:tasks/src/utils/date_time_util.dart';

import 'categories_page_bloc.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({
    Key key
  }): super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  /// Business Logic Component.
  CategoriesPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = CategoriesPageBloc();
    this.bloc.refreshCategories();
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return this.buildPage(context);
  }

  /// Build a categories list page.
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
      floatingActionButton: FloatingActionButton(
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
            this.bloc.addCategory(result);
          }
        },
      ),
    );
  }

  /// Build header this page.
  Widget pageHeader() {
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
                DateTimeUtil.currentDay,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${DateTimeUtil.currentDate} ${DateTimeUtil.currentMonth}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(height: 15.0),
              StreamBuilder(
                stream: this.bloc.streamCategories,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  String description = '...';
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    if (data.isEmpty) {
                      description = 'You not have category';
                    } else if (data.length == 1) {
                      description = 'You have 1 category';
                    } else {
                      description = 'You have ${data.length} categories';
                    }
                  }

                  return Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 18.0,
                    ),
                  );
                },
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
      child: StreamBuilder(
        stream: this.bloc.streamCategories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              final List<CategoryModel> categories = snapshot.data;
              return CategoryListView(
                data: categories,
                whenOpened: () {
                  this.bloc.refreshCategories();
                }
              );
            } else {
              return EmptyContentBox(
                message: 'no category found',
                textColor: Colors.white.withOpacity(0.85),
              );
            }
          }
        },
      ),
    );
  }
}
