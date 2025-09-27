import 'package:openapi/api.dart';

class LocalNotificationId {
  final int value;
  const LocalNotificationId(this.value);
}

enum NotificationIdStatic {
  notificationDecryptingFailed(id: LocalNotificationId(0)),

  // Common
  /// Category: NotificationCategoryNewsItemAvailable
  adminNotification(id: LocalNotificationId(10)),

  // Account
  newsItemAvailable(id: LocalNotificationId(20)),

  // Profile
  profileNameModerationAccepted(id: LocalNotificationId(30)),
  profileNameModerationRejected(id: LocalNotificationId(31)),
  profileTextModerationAccepted(id: LocalNotificationId(32)),
  profileTextModerationRejected(id: LocalNotificationId(33)),
  automaticProfileSearchCompleted(id: LocalNotificationId(34)),

  // Media
  mediaContentModerationAccepted(id: LocalNotificationId(40)),
  mediaContentModerationRejected(id: LocalNotificationId(41)),
  mediaContentModerationDeleted(id: LocalNotificationId(42)),

  // Chat
  likeReceived(id: LocalNotificationId(50)),
  genericMessageReceived(id: LocalNotificationId(51)),
  firstNewMessageNotificationId(id: LocalNotificationId(1000));

  final LocalNotificationId id;
  const NotificationIdStatic({required this.id});

  static LocalNotificationId calculateNotificationIdForNewMessageNotifications(
    ConversationId idStartingFromZero,
  ) {
    return LocalNotificationId(firstNewMessageNotificationId.id.value + idStartingFromZero.id);
  }

  static ConversationId revertNewMessageNotificationIdCalcualtion(ConversationId notificationId) {
    return ConversationId(id: notificationId.id - firstNewMessageNotificationId.id.value);
  }
}
