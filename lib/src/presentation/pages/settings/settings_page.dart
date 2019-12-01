import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:tasks/src/app.dart';
import 'package:tasks/src/core/provider.dart';

import 'settings_controller.dart';

part 'widgets/page_body.dart';
part 'widgets/page_header.dart';

class SettingsPage extends StatefulWidget {
  /// Create a SettingsPage widget.
  SettingsPage({
    Key key,
  }): super(key: key);

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController controller;
  PackageInfo appInfo;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();

    this.controller = SettingsController();
    this.appInfo = App.of(this.context);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(SettingsPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the SettingsPage widget with state.
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
    return Builder(
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _PageHeader(),
              _PageBody(appInfo: this.appInfo),
            ],
          ),
        );
      },
    );
  }
}
