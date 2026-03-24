import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_database_manager.dart';
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

  Future<void> handleNewsCountUpdate(int currentCount, AccountDatabaseManager db) async {
    if (currentCount > 0) {
      await _updateNotification(true, db);
    } else {
      await _updateNotification(false, db);
    }
  }

  Future<void> hide(AccountDatabaseManager db) => _updateNotification(false, db);

  Future<void> _updateNotification(bool show, AccountDatabaseManager db) async {
    if (!show) {
      await notifications.hideNotification(NotificationIdStatic.newsItemAvailable.id);
      return;
    }

    await notifications.sendNotification(
      id: NotificationIdStatic.newsItemAvailable.id,
      title: R.strings.notification_news_item_available,
      category: const NotificationCategoryNewsItemAvailable(),
      db: db,
    );
  }

  Future<void> showAdminNotification(
    AdminNotification notificationContent,
    AccountDatabaseManager db,
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
      db: db,
    );
  }
}
