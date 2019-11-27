import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/project_model.dart';

class PageHeader extends StatelessWidget {
  /// Create a PageHeader widget.
  PageHeader({
    Key key,
    @required this.model,
  }): super(key: key);

  final ProjectModel model;

  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: Text(
              this.model.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Edit project button.
          FlatButton(
            padding: EdgeInsets.all(12.0),
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 4.0,
              ),
            ),
            child: const Icon(Icons.edit),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/project/task');
            },
          ),
        ],
      ),
    );
  }
}
