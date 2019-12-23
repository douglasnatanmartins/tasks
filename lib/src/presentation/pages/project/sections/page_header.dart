part of '../project_layout.dart';

class PageHeader extends StatelessWidget {
  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectController>(context);
    var project = controller.project;

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
              project.title,
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
                    return ProjectDetailPage(project: project);
                  },
                ),
              );

              if (result is ProjectEntity) {
                controller.updateProject(result);
              }
            },
          ),
        ],
      ),
    );
  }
}
