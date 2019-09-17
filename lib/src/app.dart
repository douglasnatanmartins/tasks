import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tasks/src/presentation/pages/home/home_page.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/ui_colors.dart';
import 'package:tasks/src/provider.dart';

class App extends StatelessWidget {
  final String title = 'Tenla: Tasks';

  /// Build the application.
  @override
  Widget build(BuildContext context) {
    // Set device orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Provider<HomePageBloc>(
      bloc: HomePageBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: HomePage(),
        theme: ThemeData(
          primaryColor: UIColors.Blue,
          errorColor: UIColors.Orange,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: UIColors.Blue
          )
        )
      )
    );
  }
}
