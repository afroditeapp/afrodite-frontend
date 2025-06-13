

import 'package:database/database.dart';

class NotificationId {
  final int value;
  const NotificationId(this.value);
}

enum NotificationIdStatic {
  likeReceived(id: NotificationId(0)),
  mediaContentModerationAccepted(id: NotificationId(1)),
  mediaContentModerationRejected(id: NotificationId(2)),
  newsItemAvailable(id: NotificationId(3)),
  profileTextModerationAccepted(id: NotificationId(4)),
  profileTextModerationRejected(id: NotificationId(5)),
  automaticProfileSearchCompleted(id: NotificationId(6)),
  /// Category: NotificationCategoryNewsItemAvailable
  adminNotification(id: NotificationId(7)),
  lastStaticId(id: NotificationId(1000000));

  final NotificationId id;
  const NotificationIdStatic({
    required this.id,
  });

  static NotificationId calculateNotificationIdForNewMessageNotifications(NewMessageNotificationId idStartingFromZero) {
    return NotificationId(lastStaticId.id.value + 1 + idStartingFromZero.id);
  }

  static NewMessageNotificationId revertNewMessageNotificationIdCalcualtion(NotificationId notificationId) {
    return NewMessageNotificationId(notificationId.value - lastStaticId.id.value - 1);
  }
}
