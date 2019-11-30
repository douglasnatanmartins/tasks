import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/app.dart';
import 'package:tasks/src/core/provider.dart';

import 'settings_controller.dart';
import 'widgets/page_header.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key key
  }): super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Business Logic Component.
  SettingsController controller;
  PackageInfo app;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.controller = SettingsController();
    this.app = App.of(this.context);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return Component<SettingsController>.value(
      value: this.controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: this.buildPage(),
      ),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.headerPage(),
          this.bodyPage(),
        ],
      ),
    );
  }

  /// Build header this page.
  Widget headerPage() {
    return PageHeader();
  }

  /// Build body this page.
  Widget bodyPage() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[400],
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Text(
                      'About',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Version'),
                  trailing: Text(this.app.version),
                ),
                ListTile(
                  title: const Text('Third-party software'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
