
import 'package:database/database.dart';

class NotificationId {
  final int value;
  const NotificationId(this.value);
}

enum NotificationIdStatic {
  /// Server uses this as FCM collapse ID for data messages.
  empty(id: NotificationId(0)),
  /// Server sends this FCM visible notification if client does not respond
  /// to the data message.
  newNotificationAvailable(id: NotificationId(1)),

  // Notifications which client shows

  likeReceived(id: NotificationId(2)),
  mediaContentModerationAccepted(id: NotificationId(3)),
  mediaContentModerationRejected(id: NotificationId(4)),
  newsItemAvailable(id: NotificationId(5)),
  profileTextModerationAccepted(id: NotificationId(6)),
  profileTextModerationRejected(id: NotificationId(7)),
  automaticProfileSearchCompleted(id: NotificationId(8)),
  /// Category: NotificationCategoryNewsItemAvailable
  adminNotification(id: NotificationId(9)),
  firstNewMessageNotificationId(id: NotificationId(1000));

  final NotificationId id;
  const NotificationIdStatic({
    required this.id,
  });

  static NotificationId calculateNotificationIdForNewMessageNotifications(NewMessageNotificationId idStartingFromZero) {
    return NotificationId(firstNewMessageNotificationId.id.value + idStartingFromZero.id);
  }

  static NewMessageNotificationId revertNewMessageNotificationIdCalcualtion(NotificationId notificationId) {
    return NewMessageNotificationId(notificationId.value - firstNewMessageNotificationId.id.value);
  }
}
