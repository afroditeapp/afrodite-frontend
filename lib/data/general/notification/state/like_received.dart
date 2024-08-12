



import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/app_visibility_provider.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
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

  Future<void> incrementReceivedLikesCount(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    _receivedCount++;

    if (!isLikesUiOpen()) {
      await _updateNotification(accountBackgroundDb);
    }
  }

  Future<void> resetReceivedLikesCount(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    _receivedCount = 0;
    await _updateNotification(accountBackgroundDb);
  }

  Future<void> _updateNotification(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    if (_receivedCount <= 0) {
      await notifications.hideNotification(NotificationIdStatic.likeReceived.id);
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
        sessionId: await notifications.getSessionId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  bool isLikesUiOpen() {
    final likesScreenOpen = (NavigationStateBlocInstance.getInstance().bloc.state.pages.length == 1 &&
      BottomNavigationStateBlocInstance.getInstance().bloc.state.screen == BottomNavigationScreenId.likes) ||
      (NavigationStateBlocInstance.getInstance().bloc.state.pages.lastOrNull?.pageInfo is LikesPageInfo);
    return likesScreenOpen && AppVisibilityProvider.getInstance().isForeground;
  }
}
