
import 'package:app/utils/result.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class NotificationNewsItemAvailable extends AppSingletonNoInit {
  NotificationNewsItemAvailable._();
  static final _instance = NotificationNewsItemAvailable._();
  factory NotificationNewsItemAvailable.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  Future<Result<void, void>> handleNewsCountUpdate(UnreadNewsCountResult r, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final currentCount = await accountBackgroundDb.accountStream((db) => db.daoNews.watchUnreadNewsCount()).firstOrNull;
    final currentCountInt = currentCount?.c ?? 0;
    if (currentCountInt < r.c.c) {
      await _updateNotification(true, accountBackgroundDb);
    } else if (r.c.c == 0) {
      await _updateNotification(false, accountBackgroundDb);
    }

    return await accountBackgroundDb.accountAction((db) => db.daoNews.setUnreadNewsCount(unreadNewsCount: r.c, version: r.v));
  }

  Future<void> hide(AccountBackgroundDatabaseManager accountBackgroundDb) =>
    _updateNotification(false, accountBackgroundDb);

  Future<void> _updateNotification(bool show, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    if (!show) {
      await notifications.hideNotification(NotificationIdStatic.newsItemAvailable.id);
      return;
    }

    await notifications.sendNotification(
      id: NotificationIdStatic.newsItemAvailable.id,
      title: R.strings.notification_news_item_available,
      category: const NotificationCategoryNewsItemAvailable(),
      notificationPayload: NavigateToNews(
        sessionId: await notifications.getSessionId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}
