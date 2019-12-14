import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';

import 'settings_controller.dart';
import 'settings_layout.dart';

class SettingsPage extends StatelessWidget {
  /// Create a SettingsPage widget.
  SettingsPage({
    Key key,
  }): super(key: key);

  /// Build the SettingsPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<SettingsController>(
      creator: (context) => SettingsController(),
      disposer: (context, component) => component.dispose(),
      child: SettingsLayout(),
    );
  }
}
