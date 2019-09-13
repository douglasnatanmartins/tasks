import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/presentation/pages/home/home_page.dart';

class App extends StatelessWidget {
  final String _title = 'Tasks';

  /// Build the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final primaryColor = Color.fromRGBO(7, 104, 159, 1.0);
    final errorColor = Color.fromRGBO(255, 126, 103, 1.0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: HomePage(),
      theme: ThemeData(
        primaryColor: primaryColor,
        errorColor: errorColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: primaryColor
        )
      )
    );
  }
}
