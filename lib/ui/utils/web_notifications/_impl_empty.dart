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
