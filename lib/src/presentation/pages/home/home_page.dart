import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerPage(),
      body: _bodyPage()
    );
  }

  /// Create app bar for scaffold widget.
  Widget _headerPage() {
    return AppBar(
      title: Text('Tasks'),
      centerTitle: true
    );
  }

  Widget _bodyPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              Expanded(
                child: FlatButton(
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
              )
            ]
          )
        ),
        _buildListView()
      ]
    );
  }

  Widget _buildListView() {
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: _bloc.streamCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              final List<CategoryModel> categories = snapshot.data;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final CategoryModel category = categories[index];
                  return ListTile(
                    title: Text(category.title),
                    subtitle: Text(category.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(category: category)
                        )
                      ).then((_) {
                        _bloc.refreshCategories();
                      });
                    }
                  );
                }
              );
            } else {
              return Center(
                child: Text('Empty')
              );
            }
          }
        )
      )
    );
  }
}
