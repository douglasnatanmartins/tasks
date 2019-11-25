import 'package:flutter/material.dart';

typedef RouteGenerator = Route Function(RouteSettings settings);

class Router extends StatelessWidget {
  /// Create a Router widget.
  /// 
  /// The [onGenerateRoute] argument must not be null.
  Router({
    Key key,
    @required this.onGenerateRoute,
  }): assert(onGenerateRoute != null),
      super(key: key);

  final RouteGenerator onGenerateRoute;
  final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  static Router of(BuildContext context) {
    return context.ancestorWidgetOfExactType(Router) as Router;
  }

  /// Build the Router widget.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.pop,
      child: Navigator(
        key: this.navigator,
        onGenerateRoute: this.onGenerateRoute,
      ),
    );
  }

  Future<bool> pop() async {
    if (navigator.currentState.canPop()) {
      return await navigator.currentState.maybePop();
    } else {
      Navigator.of(navigator.currentContext).maybePop();
      return true;
    }
  }
}
