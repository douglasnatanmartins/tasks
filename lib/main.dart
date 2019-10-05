import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/app.dart';

void main() async {
  PackageInfo appInfo = await PackageInfo.fromPlatform();

  // Running the application.
  runApp(App(information: appInfo));
}
