import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/pages/home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(7, 104, 159, 1.0);
    final errorColor = Color.fromRGBO(255, 126, 103, 1.0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tasks",
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
