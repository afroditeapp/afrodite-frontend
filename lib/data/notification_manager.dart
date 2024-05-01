import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("NotificationManager");

const _ANDROID_ICON_RESOURCE_NAME = "ic_notification";
// TODO(prod): Check local notifications README

class NotificationManager extends AppSingleton {
  NotificationManager._private();
  static final _instance = NotificationManager._private();
  factory NotificationManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;

  final _pluginHandle = FlutterLocalNotificationsPlugin();
  late final bool _osSupportsNotificationPermission;

  bool get osSupportsNotificationPermission => _osSupportsNotificationPermission;
  PublishSubject<NotificationPayload> onReceivedPayload = PublishSubject();

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    const android = AndroidInitializationSettings(
      _ANDROID_ICON_RESOURCE_NAME
    );
    // TODO: The iOS permission settings might need to be set to false
    const darwin = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
    );
    final result = await _pluginHandle.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null) {
          return;
        }
        final parsedPayload = NotificationPayload.parse(payload);
        if (parsedPayload == null) {
          return;
        }
        onReceivedPayload.add(parsedPayload);
      }
    );

    if (result == true) {
      log.info("Local notifications initialized");
    } else {
      log.error("Failed to initialize local notifications");
    }

    _osSupportsNotificationPermission = await notificationPermissionShouldBeAsked();
  }

  Future<void> askPermissions() async {
    if (Platform.isAndroid) {
      await _pluginHandle.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await _pluginHandle.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
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

  Future<void> sendNotification(
    {
      required NotificationId id,
      required String title,
      String? body,
      required NotificationCategory category,
      NotificationPayload? notificationPayload,
    }
  ) async {
    final androidDetails = AndroidNotificationDetails(category.id, category.title);
    await _pluginHandle.show(
      id.value,
      title,
      body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notificationPayload?.toJson(),
    );
  }

  Future<void> hideNotification(NotificationId id) async {
    await _pluginHandle.cancel(id.value);
  }
}
