
import 'package:openapi/api.dart';

class LocalNotificationId {
  final int value;
  const LocalNotificationId(this.value);
}

enum NotificationIdStatic {
  /// Server uses this as FCM collapse ID for data messages.
  empty(id: LocalNotificationId(0)),
  /// Server sends this FCM visible notification if client does not respond
  /// to the data message.
  newNotificationAvailable(id: LocalNotificationId(1)),

  // Notifications which client shows

  likeReceived(id: LocalNotificationId(2)),
  mediaContentModerationAccepted(id: LocalNotificationId(3)),
  mediaContentModerationRejected(id: LocalNotificationId(4)),
  newsItemAvailable(id: LocalNotificationId(5)),
  profileNameModerationAccepted(id: LocalNotificationId(6)),
  profileNameModerationRejected(id: LocalNotificationId(7)),
  profileTextModerationAccepted(id: LocalNotificationId(8)),
  profileTextModerationRejected(id: LocalNotificationId(9)),
  automaticProfileSearchCompleted(id: LocalNotificationId(10)),
  /// Category: NotificationCategoryNewsItemAvailable
  adminNotification(id: LocalNotificationId(11)),
  genericMessageReceived(id: LocalNotificationId(12)),
  firstNewMessageNotificationId(id: LocalNotificationId(1000));

  final LocalNotificationId id;
  const NotificationIdStatic({
    required this.id,
  });

  static LocalNotificationId calculateNotificationIdForNewMessageNotifications(ConversationId idStartingFromZero) {
    return LocalNotificationId(firstNewMessageNotificationId.id.value + idStartingFromZero.id);
  }

  static ConversationId revertNewMessageNotificationIdCalcualtion(ConversationId notificationId) {
    return ConversationId(id: notificationId.id - firstNewMessageNotificationId.id.value);
  }
}
