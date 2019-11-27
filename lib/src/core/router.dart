import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/controllers/categories_controller_interface.dart';
import 'package:tasks/src/presentation/controllers/projects_controller_interface.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/category/category_page.dart';
import '../presentation/pages/project/project_page.dart';
import '../presentation/pages/task/task_page.dart';
import 'provider.dart';

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
            final Map<String, dynamic> args = settings.arguments;
            return Component<CategoriesControllerInterface>.value(
              value: args['component'],
              child: CategoryPage(category: args['model']),
            );
          },
        );
      
      // Project Page.
      case '/project':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            final Map<String, dynamic> args = settings.arguments;
            return Component<ProjectsControllerInterface>.value(
              value: args['component'],
              child: ProjectPage(model: args['model']),
            );
          },
        );
      
      // Task Page.
      case '/task':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            Map<String, dynamic> arguments = settings.arguments;
            return Component<TasksControllerInterface>.value(
              value: arguments['component'],
              child: TaskPage(model: arguments['model']),
            );
          },
        );
      
      // Default Page.
      default: return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                height: 100.0,
                width: 340.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Page not defined or feature is comming.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Back previous screen ...',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}