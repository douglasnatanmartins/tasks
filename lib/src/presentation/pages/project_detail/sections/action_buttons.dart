part of '../project_detail_layout.dart';

class ActionButtons extends StatelessWidget {
  /// Create a ActionButtons widget.
  ActionButtons({
    Key key,
  }): super(key: key);

  /// Build the ActionButtons widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectDetailController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.project.title.isEmpty) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Title must not empty'),
                ),
              );
            } else {
              Navigator.of(context).pop(controller.project);
            }
          },
          child: Text(
            controller.project.id != null ? 'Save' : 'Create',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
