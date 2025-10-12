import 'dart:async';
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

Stream<NotificationPermissionStatus> watchWebNotificationPermission() async* {
  final descriptor = {'name': 'notifications'.toJS}.jsify() as JSObject;
  final permissionsResult = await window.navigator.permissions.query(descriptor).toDart;
  final controller = StreamController<NotificationPermissionStatus>();
  permissionsResult.addEventListener(
    'change',
    (Event _) {
      controller.add(getWebNotificationPermission());
    }.toJS,
  );
  yield* controller.stream;
}

/// Displays a web notification through the service worker if permission has been granted.
///
/// Parameters:
/// - [title]: The title of the notification
/// - [body]: The body text of the notification (optional)
/// - [tag]: A tag to identify the notification (notifications with the same tag replace each other)
///
/// Returns true if the notification was displayed, false otherwise.
Future<bool> displayWebNotification({
  required String title,
  String? body,
  required String tag,
}) async {
  // Check if notifications are supported
  if (!webNotificationsSupported()) {
    return false;
  }

  // Check if permission is granted
  if (getWebNotificationPermission() != NotificationPermissionStatus.granted) {
    return false;
  }

  try {
    // Get the service worker registration
    final registration = await window.navigator.serviceWorker.ready.toDart;

    // Create notification options
    final options = NotificationOptions(body: body ?? '', tag: tag, requireInteraction: true);

    // Display notification through service worker
    await registration.showNotification(title, options).toDart;
    return true;
  } catch (e) {
    return false;
  }
}
