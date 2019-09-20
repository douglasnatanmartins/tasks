import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/categories/categories_page_bloc.dart';
import 'package:tasks/src/presentation/pages/category/category_page.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/category_card.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/new_category_form.dart';
import 'package:tasks/src/presentation/ui_colors.dart';
import 'package:tasks/src/utils/date_time_util.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesPageState();
  }
}

class _CategoriesPageState extends State<CategoriesPage> {
  final int id = 1;
  CategoriesPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = CategoriesPageBloc();
    this.bloc.refreshCategories();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build the home page.
  @override
  Widget build(BuildContext context) {
    return this.buildPage(context);
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.Blue,
      body: bodyPage(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(
            color: UIColors.Blue,
            width: 5.0
          )
        ),
        elevation: 0,
        child: Icon(Icons.add, size: 30),
        foregroundColor: UIColors.Blue,
        backgroundColor: Colors.white,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Hero(
        tag: 'bottom-navigation-bar',
        child: BottomNavigation(context: context, current: this.id)
      )
    );
  }

  /// Build body this page.
  Widget bodyPage() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateTimeUtil.currentDay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0
                  )
                ),
                Text(
                  '${DateTimeUtil.currentDate} ${DateTimeUtil.currentMonth}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 25.0
                  )
                ),
                SizedBox(height: 15.0),
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
                        fontSize: 18.0
                      )
                    );
                  }
                )
              ]
            )
          ),
          Container(
            child: Expanded(
              child: bodyContent()
            )
          )
        ]
      )
    );
  }

  /// Build main content this page.
  Widget bodyContent() {
    return StreamBuilder(
      stream: this.bloc.streamCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            final List<CategoryModel> categories = snapshot.data;
            return buildListCategories(categories);
          } else {
            return EmptyContentBox(
              message: 'no category found',
              textColor: Colors.white.withOpacity(0.85),
            );
          }
        }
      }
    );
  }

  /// Build the listview to show categories.
  Widget buildListCategories(List<CategoryModel> categories) {
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
        ).then((_) {
          this.bloc.refreshCategories();
        });
      }
    );
  }
}
