import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/presentation/pages/home/home_page.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class App extends StatelessWidget {
  final String title = 'Tenla: Tasks';

  /// Build the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primaryColor: UIColors.Blue,
        errorColor: UIColors.Orange,
      )
    );
  }
}
