import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'planned_controller.dart';
import 'widgets/page_body.dart';
import 'widgets/page_header.dart';

class PlannedPage extends StatefulWidget {
  PlannedPage({
    Key key
  }): super(key: key);

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  // Business Logic Component
  PlannedController controller;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.controller = PlannedController();
  }

  @override
  void didUpdateWidget(PlannedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    return Component<PlannedController>.value(
      value: this.controller,
      child: this.buildPage(),
    );
  }

  /// Build a planned page.
  Widget buildPage() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(),
            PageBody(),
          ],
        ),
      ),
    );
  }
}
