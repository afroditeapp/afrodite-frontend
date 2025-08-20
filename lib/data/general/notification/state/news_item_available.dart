import 'package:app/utils/result.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
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

  Future<Result<(), ()>> handleNewsCountUpdate(
    UnreadNewsCountResult r,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final currentCount = await accountBackgroundDb
        .accountStream((db) => db.news.watchUnreadNewsCount())
        .firstOrNull;
    final currentCountInt = currentCount?.c ?? 0;
    if (currentCountInt < r.c.c) {
      await _updateNotification(true, accountBackgroundDb);
    } else if (r.c.c == 0) {
      await _updateNotification(false, accountBackgroundDb);
    }

    return await accountBackgroundDb
        .accountAction((db) => db.news.setUnreadNewsCount(unreadNewsCount: r.c, version: r.v))
        .emptyErr();
  }

  Future<void> hide(AccountBackgroundDatabaseManager accountBackgroundDb) =>
      _updateNotification(false, accountBackgroundDb);

  Future<void> _updateNotification(
    bool show,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    if (!show) {
      await notifications.hideNotification(NotificationIdStatic.newsItemAvailable.id);
      return;
    }

    await notifications.sendNotification(
      id: NotificationIdStatic.newsItemAvailable.id,
      title: R.strings.notification_news_item_available,
      category: const NotificationCategoryNewsItemAvailable(),
      notificationPayload: NavigateToNews(receiverAccountId: accountBackgroundDb.accountId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  Future<Result<(), ()>> showAdminNotification(
    AdminNotification notificationContent,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    Map<String, dynamic> booleanValues = notificationContent.toJson();
    List<String> trueValues = [];
    for (final e in booleanValues.entries) {
      if (e.value == true) {
        trueValues.add(e.key);
      }
    }
    await notifications.sendNotification(
      id: NotificationIdStatic.adminNotification.id,
      title: "Admin notification",
      body: trueValues.join("\n"),
      category: const NotificationCategoryNewsItemAvailable(),
      notificationPayload: NavigateToModeratorTasks(
        receiverAccountId: accountBackgroundDb.accountId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );

    return await accountBackgroundDb
        .accountAction((db) => db.notification.updateAdminNotification(notificationContent))
        .emptyErr();
  }
}
