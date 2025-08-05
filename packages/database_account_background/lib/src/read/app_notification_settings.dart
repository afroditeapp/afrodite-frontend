
import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'app_notification_settings.g.dart';

@DriftAccessor(
  tables: [
    schema.AppNotificationSettings,
  ]
)
class DaoReadAppNotificationSettings extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoReadAppNotificationSettingsMixin {
  DaoReadAppNotificationSettings(super.db);

  Stream<api.ProfileAppNotificationSettings?> watchProfileAppNotificationSettings() =>
    _watchColumn((r) {
      final profileStringModerationCompleted = r.profileStringModerationCompleted;
      final automaticProfileSearch = r.automaticProfileSearch;

      if (
        profileStringModerationCompleted == null ||
        automaticProfileSearch == null
      ) {
        return null;
      }

      return api.ProfileAppNotificationSettings(
        profileStringModeration: profileStringModerationCompleted,
        automaticProfileSearch: automaticProfileSearch,
      );
    });

  Stream<bool?> watchMessages() =>
    _watchColumn((r) => r.messages);
  Stream<bool?> watchLikes() =>
    _watchColumn((r) => r.likes);
  Stream<bool?> watchMediaContentModerationCompleted() =>
    _watchColumn((r) => r.mediaContentModerationCompleted);
  Stream<bool?> watchNews() =>
    _watchColumn((r) => r.news);

  Stream<T?> _watchColumn<T extends Object>(T? Function(AppNotificationSetting) extractColumn) {
    return (select(appNotificationSettings)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
