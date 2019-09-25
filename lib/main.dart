import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tasks/src/app.dart';

void main() {
  PackageInfo.fromPlatform().then((data) {
    runApp(App(information: data));
  });
}
