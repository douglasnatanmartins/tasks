import 'dart:async';

import 'package:package_info/package_info.dart';
import 'package:tasks/src/core/contracts/controller.dart';

/// Settings Page Business Logic Component.
class SettingsController implements Controller {
  SettingsController() {
    _getAppInformation().then((data) {
      _infoController.sink.add(_information);
    });
  }

  final _infoController = StreamController<PackageInfo>.broadcast();
  Stream<PackageInfo> get information => _infoController.stream;
  PackageInfo _information;

  Future<void> _getAppInformation() async {
    _information = await PackageInfo.fromPlatform();
  }

  @override
  void dispose() {
    _infoController.close();
  }
}
