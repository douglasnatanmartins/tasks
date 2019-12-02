part of '../category_page.dart';

class _ProjectCard extends StatelessWidget {
  /// Create a _ProjectCard widget.
  _ProjectCard({
    Key key,
    @required this.model,
  })  : assert(model != null),
        super(key: key);

  final ProjectEntity model;

  /// Build the _ProjectCard widget.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this._buildTile(),
      onTap: () {
        final component = Component.of<CategoryController>(context);
        Navigator.of(context).pushNamed(
          '/project',
          arguments: <String, dynamic>{
            'component': component,
            'model': this.model,
          },
        );
      },
    );
  }

  Widget _buildTile() {
    List<Widget> children = <Widget>[];

    children.add(
      Text(
        this.model.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.blue[600],
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (this.model.description != null && this.model.description.isNotEmpty) {
      children.add(const SizedBox(height: 6.0));
      children.add(
        Text(
          this.model.description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      );
    }

    children.add(const SizedBox(height: 5.0));
    children.add(
      Text(
        'Created on ${DateFormat.yMMMd().format(this.model.createdDate)}',
        style: TextStyle(
          color: Colors.black.withOpacity(0.45),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  this.model.icon,
                  size: 30.0,
                  color: this.model.color,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: children,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Consumer<CategoryController>(
            builder: (context, component) {
              return FutureBuilder<double>(
                initialData: 0.0,
                future: component.getProgressProject(this.model.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: LinearProgressIndicator(
                          value: snapshot.data,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text((snapshot.data * 100).round().toString() + '%'),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
