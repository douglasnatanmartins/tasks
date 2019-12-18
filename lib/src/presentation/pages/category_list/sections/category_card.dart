part of '../category_list_layout.dart';

class _CategoryCard extends StatelessWidget {
  /// Create a CategoryCard widget.
  _CategoryCard({
    Key key,
    @required this.data,
  }): super(key: key);

  final CategoryEntity data;

  /// Build the CategoryCard widget.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildChildren(),
          ),
        ),
      ),
      onTap: () {
        var controller = Provider.of<CategoryListController>(context);
        Navigator.of(context).pushNamed(
          '/category',
          arguments: <String, dynamic>{
            'component': controller,
            'model': data,
          },
        );
      },
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = <Widget>[];
    children.add(const Spacer(flex: 5));

    // If has category description.
    if (data.description != null) {
      children.add(
        Text(
          data.description ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      );
      children.add(const SizedBox(height: 5));
    }

    // Add category title.
    children.add(
      Text(
        data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.blue[400],
          fontSize: 28,
        ),
      ),
    );

    return children;
  }
}
