



import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/utils.dart';

class NotificationLikeReceived extends AppSingletonNoInit {
  NotificationLikeReceived._();
  static final _instance = NotificationLikeReceived._();
  factory NotificationLikeReceived.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  int _receivedCount = 0;

  Future<void> incrementReceivedLikesCount() async {
    _receivedCount++;

    if (!isLikesUiOpen()) {
      await _updateNotification();
    }
  }

  Future<void> resetReceivedLikesCount() async {
    _receivedCount = 0;
    await _updateNotification();
  }

  Future<void> _updateNotification() async {
    if (_receivedCount <= 0) {
      await notifications.hideNotification(NotificationIdStatic.likeReceived.id);
      return;
    }

    final sessionId = await db.commonStreamSingle((db) => db.watchNotificationSessionId());
    if (sessionId == null) {
      return;
    }

    final String title;
    if (_receivedCount == 1) {
      title = R.strings.notification_like_received_single;
    } else {
      title = R.strings.notification_like_received_multiple;
    }

    await notifications.sendNotification(
      id: NotificationIdStatic.likeReceived.id,
      title: title,
      category: const NotificationCategoryLikes(),
      notificationPayload: NavigateToLikes(
        sessionId: sessionId,
      ),
    );
  }

  bool isLikesUiOpen() {
    return NavigationStateBlocInstance.getInstance().bloc.state.pages.length == 1 &&
      BottomNavigationStateBlocInstance.getInstance().bloc.state.screen == BottomNavigationScreenId.likes;
  }
}
