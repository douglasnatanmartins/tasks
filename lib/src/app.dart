import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'router.dart';

class App extends StatelessWidget {
  final PackageInfo information;

  App({
    Key key,
    @required this.information
  }): assert(information != null),
      super(key: key);

  /// Get the object contains application information.
  static PackageInfo of(BuildContext context) {
    return (context.ancestorWidgetOfExactType(App) as App).information;
  }

  /// Build the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: this.information.appName,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
