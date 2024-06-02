

import 'package:database/database.dart';

class NotificationId {
  final int value;
  const NotificationId(this.value);
}

enum NotificationIdStatic {
  likeReceived(id: NotificationId(0)),
  moderationRequestStatus(id: NotificationId(1)),
  /// Message received but no info about who sent it.
  messageReceived(id: NotificationId(2)),
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
