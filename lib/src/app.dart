import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/shared/widgets/route_not_defined.dart';

import 'core/router.dart';
import 'presentation/blocs/categories_bloc.dart';
import 'presentation/blocs/tasks_bloc.dart';
import 'presentation/pages/home/home_page.dart';

class App extends StatelessWidget {
  /// The root widget application.
  /// 
  /// The [information] arguments must not be null.
  /// The `information` contains application metadata.
  const App({
    Key key,
    @required this.information,
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

    return Component<CategoriesBloc>(
      creator: (context) => CategoriesBloc(),
      disposer: (context, component) => component?.dispose(),
      child: Component<TasksBloc>(
        creator: (context) => TasksBloc(),
        disposer: (context, component) => component?.dispose(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: this.information.appName,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                );
                break;
              default:
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteNotDefined(route: settings.name);
                  },
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
