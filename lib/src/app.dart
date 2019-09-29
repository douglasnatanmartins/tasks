import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'package:tasks/src/presentation/pages/home/home_page.dart';

class App extends StatelessWidget {
  final String title = 'Tenla: Tasks';
  final PackageInfo information;

  App({
    Key key,
    @required this.information
  }): assert(information != null),
      super(key: key);
  
  /// Get the application information.
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
      home: HomePage()
    );
  }
}
