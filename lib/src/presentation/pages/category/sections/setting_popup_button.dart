part of '../category_layout.dart';

class SettingPopupButton extends StatelessWidget {
  /// Build the SettingPopupButton widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryController>(context);

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return const <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),
        ];
      },
      onSelected: (selected) async {
        if (selected == 'edit') {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CategoryDetailPage(category: controller.category);
              },
            ),
          );

          if (result is CategoryEntity) {
            controller.updateCategory(result);
          }
        }

        if (selected == 'delete') {
          var result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CategoryDeleteDialog();
            },
          );

          if (result != null && result) {
            controller.deleteCategory();
            Navigator.of(context).pop();
          }
        }
      }
    );
  }
}
