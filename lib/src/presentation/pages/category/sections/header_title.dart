part of '../category_layout.dart';

class HeaderTitle extends StatelessWidget {
  /// Build the HeaderTitle widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryController>(context);

    return StreamBuilder<CategoryEntity>(
      initialData: controller.category,
      stream: controller.categoryStream,
      builder: (context, snapshot) {
        var category = snapshot.data;
        List<Widget> children = <Widget>[];
        children.add(
          Text(
            category.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.title.copyWith(
              fontSize: 22.0,
            ),
          ),
        );

        if (category.description != null) {
          children.add(
            Text(
              category.description,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      },
    );
  }
}
