import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

part 'sections/page_body.dart';
part 'sections/page_header.dart';

class SettingsLayout extends StatelessWidget {
  /// Create a SettingsLayout widget.
  SettingsLayout({
    Key key,
    @required this.appInfo,
  }): super(key: key);

  final PackageInfo appInfo;

  /// Build the SettingsLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _PageHeader(),
            _PageBody(appInfo: appInfo),
          ],
        ),
      ),
    );
  }
}
