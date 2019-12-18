part of '../category_layout.dart';

class _ProjectCard extends StatelessWidget {
  /// Create a ProjectCard widget.
  /// 
  /// The [data] argument must not be null.
  _ProjectCard({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  final ProjectEntity data;

  /// Build the ProjectCard widget.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildTile(),
      onTap: () {
        var controller = Provider.of<CategoryController>(context);
        Navigator.of(context).pushNamed(
          '/project',
          arguments: <String, dynamic>{
            'component': controller,
            'model': data,
          },
        );
      },
    );
  }

  Widget _buildTile() {
    List<Widget> children = <Widget>[];

    children.add(
      Text(
        data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.blue[600],
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (data.description != null && data.description.isNotEmpty) {
      children.add(const SizedBox(height: 6.0));
      children.add(
        Text(
          data.description,
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
        'Created on ${DateFormat.yMMMd().format(data.createdDate)}',
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
                  data.icon,
                  size: 30.0,
                  color: data.color,
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
            builder: (context, controller) {
              return FutureBuilder<double>(
                initialData: 0,
                future: controller.getProgressProject(data.id),
                builder: (context, snapshot) {
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
