import 'package:flutter/material.dart';

import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/category/category_page.dart';
import '../presentation/pages/project/project_page.dart';
import '../presentation/pages/task/task_page.dart';
import '../presentation/shared/widgets/route_not_defined.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Home Page.
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePage();
          },
        );

      // Category Page.
      case '/category':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            Map<String, dynamic> args = settings.arguments;
            return CategoryPage(
              arguments: CategoryPageArguments(
                category: args['model'],
                manager: args['component'],
              ),
            );
          },
        );

      // Project Page.
      case '/project':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            Map<String, dynamic> args = settings.arguments;
            return ProjectPage(
              arguments: ProjectPageArguments(
                manager: args['component'],
                project: args['model'],
              ),
            );
          },
        );
      
      // Task Page.
      case '/task':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            Map<String, dynamic> args = settings.arguments;
            return TaskPage(
              arguments: TaskPageArguments(
                manager: args['component'],
                task: args['model'],
              ),
            );
          },
        );
      
      // Default Page.
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return RouteNotDefined(route: settings.name);
          },
        );
    }
  }
}
