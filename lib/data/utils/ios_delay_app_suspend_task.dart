import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:utils/utils.dart';

final _log = Logger("IosDelayAppSuspendTask");

class IosDelayAppSuspendTask {
  static const MethodChannel _channel = MethodChannel("delay_app_suspend_task");

  /// Does nothing on platforms other than iOS
  static Future<void> allow() => _runMethod("allow");

  /// Does nothing on platforms other than iOS
  static Future<void> forbid() => _runMethod("forbid");

  /// Does nothing on platforms other than iOS
  static Future<void> dispose() => _runMethod("dispose");

  static Future<void> _runMethod(String method) async {
    if (kIsWeb || !Platform.isIOS) {
      return;
    }
    try {
      await _channel.invokeMethod(method);
    } catch (_) {
      _log.error("$method failed");
    }
  }
}
