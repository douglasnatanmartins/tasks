import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';

part 'layout/page_body.dart';
part 'layout/page_header.dart';
part 'widgets/field.dart';

class CategoryDetailPage extends StatefulWidget {
  /// Create a CategoryDetailPage widget.
  CategoryDetailPage({
    Key key,
    @required this.category,
  }): super(key: key);

  final CategoryEntity category;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  CategoryEntity data;
  TextEditingController titleController;
  TextEditingController descriptionController;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    if (this.widget.category == null) {
      this.data = CategoryEntity(
        id: null,
        title: '',
        description: null,
        createdDate: DateTime.now(),
      );
    } else {
      this.data = this.widget.category;
    }

    this.titleController = TextEditingController.fromValue(
      TextEditingValue(text: this.data.title),
    );

    this.descriptionController = TextEditingController.fromValue(
      TextEditingValue(text: this.data.description ?? ''),
    );
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CategoryDetailPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the CategoryDetailPage widget with state.
  @override
  Widget build(BuildContext context) {
    return ComponentInherited<_Shared>(
      value: _Shared(
        data: this.data,
        titleController: this.titleController,
        descriptionController: this.descriptionController,
      ),
      child: this.buildPage(),
      updateNotifier: (p, c) => false,
    );
  }

  Widget buildPage() {
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _PageHeader(),
                _PageBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Shared {
  _Shared({
    @required this.data,
    @required this.titleController,
    @required this.descriptionController,
  });

  final CategoryEntity data;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
}
