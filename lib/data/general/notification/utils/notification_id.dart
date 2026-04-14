import 'package:openapi/api.dart';

class LocalNotificationId {
  final int value;
  const LocalNotificationId(this.value);

  @override
  bool operator ==(Object other) {
    return other is LocalNotificationId && other.value == value;
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

enum NotificationIdStatic {
  notificationDecryptingFailed(id: LocalNotificationId(0)),

  // Common
  /// Category: NotificationCategoryNewsItemAvailable
  adminNotification(id: LocalNotificationId(10)),

  // Account
  newsItemAvailable(id: LocalNotificationId(20)),

  // Profile
  profileNameModerationCompleted(id: LocalNotificationId(30)),
  profileTextModerationCompleted(id: LocalNotificationId(31)),
  automaticProfileSearchCompleted(id: LocalNotificationId(32)),

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

  static ConversationId revertNewMessageNotificationIdCalculation(
    LocalNotificationId notificationId,
  ) {
    return ConversationId(id: notificationId.value - firstNewMessageNotificationId.id.value);
  }
}
