import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/core/provider.dart';

import 'core/router.dart';
import 'presentation/blocs/categories_bloc.dart';
import 'presentation/blocs/tasks_bloc.dart';

class App extends StatelessWidget {
  /// The root widget application.
  /// 
  /// The [information] arguments must not be null.
  const App({
    Key key,
    @required this.information
  }): assert(information != null),
      super(key: key);

  final PackageInfo information;

  /// Get the object contains application information.
  static PackageInfo of(BuildContext context) {
    return (context.ancestorWidgetOfExactType(App) as App).information;
  }

  /// Build root widget of the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Provider(
      components: <Component>[
        Component<CategoriesBloc>(
          onCreated: () => CategoriesBloc(),
          onDispose: (component) => component?.dispose(),
        ),
        Component<TasksBloc>(
          onCreated: () => TasksBloc(),
          onDispose: (component) => component?.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: this.information.appName,
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
