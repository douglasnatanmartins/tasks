part of '../project_layout.dart';

class _PageHeader extends StatelessWidget {
  /// Create a _PageHeader widget.
  _PageHeader({
    Key key,
    @required this.data,
  }) : super(key: key);

  final ProjectEntity data;

  /// Build the _PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: Text(
              data.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Edit project button.
          FlatButton(
            padding: EdgeInsets.all(12),
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 4,
              ),
            ),
            child: const Icon(Icons.edit),
            textColor: Colors.white,
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProjectDetailPage(project: data);
                  },
                ),
              );

              if (result is ProjectEntity) {
                var manager = Provider.of<ProjectManagerContract>(context);
                manager.updateProject(result, data);
              }
            },
          ),
        ],
      ),
    );
  }
}
