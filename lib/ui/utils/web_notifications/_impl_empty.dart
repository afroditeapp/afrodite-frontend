enum NotificationPermissionStatus { granted, denied, default_ }

bool webNotificationsSupported() {
  return false;
}

NotificationPermissionStatus getWebNotificationPermission() {
  return NotificationPermissionStatus.denied;
}

Future<NotificationPermissionStatus> requestWebNotificationPermission() async {
  return NotificationPermissionStatus.denied;
}

Stream<NotificationPermissionStatus> watchWebNotificationPermission() {
  return Stream.empty();
}

/// Displays a web notification through the service worker if permission has been granted.
///
/// Parameters:
/// - [title]: The title of the notification
/// - [body]: The body text of the notification (optional)
/// - [tag]: A tag to identify the notification (notifications with the same tag replace each other)
Future<void> displayWebNotification({
  required String title,
  String? body,
  required String tag,
}) async {
  // Not supported on non-web platforms
}

/// Hides (closes) a web notification through the service worker.
///
/// Parameters:
/// - [tag]: The tag identifying the notification to hide
Future<void> hideWebNotification({required String tag}) async {
  // Not supported on non-web platforms
}
