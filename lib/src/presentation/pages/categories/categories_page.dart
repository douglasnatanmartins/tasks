import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page.dart';
import 'package:tasks/src/presentation/pages/categories/categories_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/category_card.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/new_category_form.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesPageState();
  }
}

class _CategoriesPageState extends State<CategoriesPage> {
  CategoriesPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoriesPageBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  /// Build the home page.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo
      ),
      child: _bodyPage()
    );
  }

  /// Build body this page.
  Widget _bodyPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600
                )
              ),
              FlatButton(
                color: Colors.white,
                textColor: Colors.green,
                child: Icon(Icons.add),
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return NewCategoryForm();
                    }
                  );

                  if (result is CategoryModel) {
                    _bloc.addCategory(result);
                  }
                }
              )
            ]
          )
        ),
        _mainContent()
      ]
    );
  }

  /// Build main content this page.
  Widget _mainContent() {
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: _bloc.streamCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                final List<CategoryModel> categories = snapshot.data;
                return _buildListCategories(categories);
              } else {
                return EmptyContentBox(message: 'no category found');
              }
            }
          }
        )
      )
    );
  }

  /// Build the listview to show categories.
  Widget _buildListCategories(List<CategoryModel> categories) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.8
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildChildrenInList(categories[index]);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInList(CategoryModel category) {
    return GestureDetector(
      child: CategoryCard(category: category),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category: category)
          )
        ).then((_) => _bloc.refreshCategories());
      }
    );
  }
}
