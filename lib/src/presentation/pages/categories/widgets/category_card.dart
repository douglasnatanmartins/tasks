part of '../categories_page.dart';

class _CategoryCard extends StatelessWidget {
  /// Create a _CategoryCard widget.
  _CategoryCard({
    Key key,
    @required this.data,
  }): super(key: key);

  final CategoryEntity data;

  /// Build the _CategoryCard widget.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this._buildChildren(),
          ),
        ),
      ),
      onTap: () {
        final controller = Provider.of<_Shared>(context).controller;
        Navigator.of(context).pushNamed(
          '/category',
          arguments: <String, dynamic>{
            'component': controller,
            'model': this.data,
          },
        );
      },
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = <Widget>[];
    children.add(const Spacer(flex: 5));

    // If has category description.
    if (this.data.description != null) {
      children.add(
        Text(
          this.data.description ?? '',
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
        this.data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.blue[400],
          fontSize: 28.0,
        ),
      ),
    );

    return children;
  }
}
