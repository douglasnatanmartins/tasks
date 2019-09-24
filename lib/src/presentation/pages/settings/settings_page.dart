import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return buildPage();
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: UIColors.LightGrey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            headerPage(),
            bodyPage()
          ]
        )
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

  Widget bodyPage() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5)
                      )
                    ),
                    child: Text('About', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600))
                  )
                ),
                ListTile(
                  title: Text('Version'),
                  trailing: Text('1.0.0'),
                ),
                ListTile(
                  title: Text('Third-party software'),
                  trailing: Icon(Icons.arrow_forward),
                )
              ]
            )
          )
        ),
      )
    );
  }
}
