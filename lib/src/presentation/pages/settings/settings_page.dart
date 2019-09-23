import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: UIColors.LightGrey,
      body: bodyPage()
    );
  }

  Widget bodyPage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          headerPage(),
          contentBody()
        ]
      )
    );
  }

  Widget headerPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 80.0,
      child: Row(
        children: <Widget>[
          Hero(
            tag: 'on-hero-button',
            child: FlatButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              shape: CircleBorder(),
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(this.context).pop()
            )
          ),
          Text(
            'Settings',
            style: TextStyle(
              color: UIColors.DarkBlue,
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            )
          ),
        ]
      )
    );
  }

  Widget contentBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        )
      )
    );
  }
}
