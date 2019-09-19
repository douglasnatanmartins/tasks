import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/pages/important/important_page.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: UIColors.Blue
        ),
        child: Center(
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            shape: CircleBorder(),
            color: Colors.white,
            child: Icon(Icons.open_in_new),
            textColor: UIColors.Blue,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ImportantPage();
                  }
                )
              );
            },
          )
        )
      )
    );
  }
}
