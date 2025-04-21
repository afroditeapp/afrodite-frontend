

import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class NotificationAutomaticProfileSearch extends AppSingletonNoInit {
  NotificationAutomaticProfileSearch._();
  static final _instance = NotificationAutomaticProfileSearch._();
  factory NotificationAutomaticProfileSearch.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  static Future<void> handleAutomaticProfileSearchCompleted(
    AutomaticProfileSearchCompletedNotification notification,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final show = await accountBackgroundDb.accountData(
      (db) => db.daoAutomaticProfileSearchCompletedNotificationTable.shouldProfilesFoundNotificationBeShown(notification.profilesFound, notification.profilesFoundViewed)
    ).ok() ?? false;

    if (show) {
      await NotificationAutomaticProfileSearch.getInstance().show(accountBackgroundDb);
    }
  }

  Future<void> show(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final NotificationId id = NotificationIdStatic.automaticProfileSearchCompleted.id;
    final String title = R.strings.notification_automatic_profile_search_found_profiles;

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryAutomaticProfileSearch(),
      notificationPayload: NavigateToAutomaticProfileSearchResults(sessionId: await notifications.getSessionId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}
