export '_impl_empty.dart'
    if (dart.library.js_interop) '_impl_web.dart'
    show
        requestWebNotificationPermission,
        getWebNotificationPermission,
        webNotificationsSupported,
        watchWebNotificationPermission,
        displayWebNotification,
        NotificationPermissionStatus;
