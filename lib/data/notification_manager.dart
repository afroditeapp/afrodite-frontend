import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/utils.dart';

var log = Logger("NotificationManager");

// TODO(prod): Check local notifications README

class NotificationManager extends AppSingleton {
  NotificationManager._private();
  static final _instance = NotificationManager._private();
  factory NotificationManager.getInstance() {
    return _instance;
  }

  bool initDone = false;

  final pluginHandle = FlutterLocalNotificationsPlugin();
  late final bool osSupportsNotificationPermission;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    const android = AndroidInitializationSettings(
      "ic_notification",
    );
    // TODO: The iOS permission settings might need to be set to false
    const darwin = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
    );
    final result = await pluginHandle.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        log.info("Selected notification: $payload");
      }
    );

    if (result == true) {
      log.info("Local notifications initialized");
    } else {
      log.error("Failed to initialize local notifications");
    }

    osSupportsNotificationPermission = await notificationPermissionShouldBeAsked();
  }

  Future<void> askPermissions() async {
    if (Platform.isAndroid) {
      await pluginHandle.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await pluginHandle.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<bool> notificationPermissionShouldBeAsked() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<void> sendNotification() async {
    const details = AndroidNotificationDetails("channel-id", "channel-name");
    await pluginHandle.show(
      0,
      "Title",
      "Body",
      NotificationDetails(
        android: details,
      ),
      payload: "my-test-payload",
    );
  }
}
