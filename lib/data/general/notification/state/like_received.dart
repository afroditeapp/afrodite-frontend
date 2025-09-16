import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/app_visibility_provider.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/likes.dart';
import 'package:utils/utils.dart';

class NotificationLikeReceived extends AppSingletonNoInit {
  NotificationLikeReceived._();
  static final _instance = NotificationLikeReceived._();
  factory NotificationLikeReceived.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  int _receivedCount = 0;

  Future<void> incrementReceivedLikesCount(
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
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
      notificationPayload: NavigateToLikes(receiverAccountId: accountBackgroundDb.accountId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  bool isLikesUiOpen() {
    final likesScreenOpen =
        (NavigationStateBlocInstance.getInstance().navigationState.pages.length == 1 &&
            BottomNavigationStateBlocInstance.getInstance().navigationState.screen ==
                BottomNavigationScreenId.likes) ||
        (NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull is LikesPage);
    return likesScreenOpen && AppVisibilityProvider.getInstance().isForeground;
  }
}
