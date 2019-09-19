import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/presentation/pages/important/important_page.dart';
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
      home: ImportantPage(),
      theme: ThemeData(
        primaryColor: UIColors.Blue,
        errorColor: UIColors.Orange,
      )
    );

    // return Provider<HomePageBloc>(
    //   bloc: HomePageBloc(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: title,
    //     home: HomePage(),
    //     theme: ThemeData(
    //       primaryColor: UIColors.Blue,
    //       errorColor: UIColors.Orange,
    //       appBarTheme: AppBarTheme(
    //         elevation: 0,
    //         color: UIColors.Blue
    //       )
    //     )
    //   )
    // );
  }
}
