import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:utils/utils.dart';

class NotificationAutomaticProfileSearch extends AppSingletonNoInit {
  NotificationAutomaticProfileSearch._();
  static final _instance = NotificationAutomaticProfileSearch._();
  factory NotificationAutomaticProfileSearch.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  static Future<void> handleAutomaticProfileSearchCompleted(
    int profileCount,
    AccountDatabaseManager db,
  ) async {
    await NotificationAutomaticProfileSearch.getInstance().show(db, profileCount);
  }

  Future<void> show(AccountDatabaseManager db, int profileCount) async {
    final LocalNotificationId id = NotificationIdStatic.automaticProfileSearchCompleted.id;

    if (profileCount <= 0) {
      await notifications.hideNotification(id);
      return;
    }

    final String title;
    if (profileCount == 1) {
      title = R.strings.notification_automatic_profile_search_found_profiles_single;
    } else {
      title = R.strings.notification_automatic_profile_search_found_profiles_multiple(
        profileCount.toString(),
      );
    }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryAutomaticProfileSearch(),
      db: db,
    );
  }
}
