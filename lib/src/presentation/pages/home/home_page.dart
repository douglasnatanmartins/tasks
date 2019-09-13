import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/new_category_form.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomePageBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  /// Build the home page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerPage(),
      body: _bodyPage()
    );
  }

  /// Build header this page.
  Widget _headerPage() {
    return AppBar(
      title: Text('Tasks'),
      centerTitle: true
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
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                )
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
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
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              final List<CategoryModel> categories = snapshot.data;
              return _buildListView(categories);
            } else {
              return EmptyContentBox(message: 'no category found');
            }
          }
        )
      )
    );
  }

  /// Build the listview to show categories.
  Widget _buildListView(List<CategoryModel> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final CategoryModel category = categories[index];
        return _buildChildrenInListView(category);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(CategoryModel category) {
    return ListTile(
      leading: Icon(Icons.category),
      title: Text(category.title),
      subtitle: Text(category.description),
      onTap: () { // Open a category page.
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
