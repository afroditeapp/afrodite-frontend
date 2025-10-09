import 'dart:js_interop';
import 'package:web/web.dart';

enum NotificationPermissionStatus { granted, denied, default_ }

bool webNotificationsSupported() {
  // Check if Notification API is available in the browser
  try {
    return Notification.permission.isNotEmpty;
  } catch (e) {
    return false;
  }
}

NotificationPermissionStatus getWebNotificationPermission() {
  final currentPermission = Notification.permission;

  switch (currentPermission) {
    case 'granted':
      return NotificationPermissionStatus.granted;
    case 'denied':
      return NotificationPermissionStatus.denied;
    case 'default':
    default:
      return NotificationPermissionStatus.default_;
  }
}

Future<NotificationPermissionStatus> requestWebNotificationPermission() async {
  // Get current permission status
  final currentPermission = Notification.permission;

  // If already granted or denied, return current status
  if (currentPermission == 'granted') {
    return NotificationPermissionStatus.granted;
  } else if (currentPermission == 'denied') {
    return NotificationPermissionStatus.denied;
  }

  // Request permission
  try {
    final permission = await Notification.requestPermission().toDart;

    switch (permission) {
      case 'granted':
        return NotificationPermissionStatus.granted;
      case 'denied':
        return NotificationPermissionStatus.denied;
      default:
        return NotificationPermissionStatus.default_;
    }
  } catch (e) {
    return NotificationPermissionStatus.denied;
  }
}
