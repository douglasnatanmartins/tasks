import 'package:flutter/material.dart';

import 'presentation/pages/category/category_page.dart';
import 'presentation/pages/important/important_page.dart';
import 'presentation/pages/planned/planned_page.dart';
import 'presentation/pages/categories/categories_page.dart';
import 'presentation/pages/project/project_page.dart';
import 'presentation/pages/settings/settings_page.dart';
import 'presentation/pages/task/task_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Home Page.
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return PlannedPage();
          }
        );
      
      // Setting Page.
      case '/settings':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return SettingsPage();
          }
        );
      
      // Imporant Page.
      case '/important':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return ImportantPage();
          }
        );
      
      // Categories Page.
      case '/categories':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return CategoriesPage();
          }
        );
      
      // Category Page.
      case '/category':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return CategoryPage(category: settings.arguments);
          }
        );
      
      // Project Page.
      case '/project':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return ProjectPage(project: settings.arguments);
          }
        );
      
      // Task Page.
      case '/task':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return TaskPage(task: settings.arguments);
          }
        );
      
      // Default Page.
      default: return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          body: Container(
            child: Text('Router not defined.')
          )
        );
      }
    );
  }
}
