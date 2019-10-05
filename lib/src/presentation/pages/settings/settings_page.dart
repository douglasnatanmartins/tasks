import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/app.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

import 'settings_page_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Business Logic Component.
  SettingsPageBloc bloc;
  PackageInfo app;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = SettingsPageBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    app = App.of(this.context);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return this.buildPage();
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: UIColors.LightGrey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(),
            this.bodyPage()
          ]
        )
      )
    );
  }

  /// Build header this page.
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

  /// Build body this page.
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
                  trailing: Text(this.app.version),
                ),
                ListTile(
                  title: Text('Third-party software'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {}
                )
              ]
            )
          )
        ),
      )
    );
  }
}
