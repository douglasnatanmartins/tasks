import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/screen/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tasks",
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white
        )
      )
    );
  }
}
