import 'package:flutter/material.dart';

class RouteNotDefined extends StatelessWidget {
  /// Create a RouteNotDefined widget.
  RouteNotDefined({
    Key key,
    @required this.route,
  }): super(key: key);

  final String route;

  /// Build the RouteNotDefined widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'The ${this.route} is not defined!',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
