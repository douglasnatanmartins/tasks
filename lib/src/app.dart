import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/router.dart';

class App extends StatelessWidget {
  /// The root widget application.
  /// 
  /// The [information] arguments must not be null.
  /// The `information` contains application metadata.
  const App({
    Key key,
    @required this.title,
  }): assert(title != null),
      super(key: key);
  
  final String title;

  /// Build root widget of the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
