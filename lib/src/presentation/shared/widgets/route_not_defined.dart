import 'package:flutter/material.dart';

class RouteNotDefined extends StatelessWidget {
  /// Create a RouteNotDefined widget.
  /// 
  /// The [route] argument must not be null.
  RouteNotDefined({
    Key key,
    @required this.route,
  }): assert(route != null),
      super(key: key);

  final String route;

  /// Build the RouteNotDefined widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: 100,
            width: 340,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.orange[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Something wrong!',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'The "$route" route is not defined or the developing feature.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  child: Text(
                    'Back previous screen ...',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
