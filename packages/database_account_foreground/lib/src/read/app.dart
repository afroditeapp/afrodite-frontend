import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileFilterFavorites,
    schema.ShowAdvancedProfileFilters,
    schema.InitialSync,
    schema.InitialSetupSkipped,
    schema.GridSettings,
    schema.ChatBackupReminder,
  ],
)
class DaoReadApp extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadAppMixin {
  DaoReadApp(super.db);

  Stream<bool?> watchLoginSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneLoginRepository);
  Stream<bool?> watchAccountSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneAccountRepository);
  Stream<bool?> watchMediaSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneMediaRepository);
  Stream<bool?> watchProfileSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneProfileRepository);
  Stream<bool?> watchChatSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneChatRepository);

  Stream<T?> _watchColumnInitialSync<T extends Object>(T? Function(InitialSyncData) extractColumn) {
    return (select(
      initialSync,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchInitialSetupSkipped() =>
      _watchColumnInitialSetupSkipped((r) => r.initialSetupSkipped);

  Stream<T?> _watchColumnInitialSetupSkipped<T extends Object>(
    T? Function(InitialSetupSkippedData) extractColumn,
  ) {
    return (select(
      initialSetupSkipped,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchProfileFilterFavorites() =>
      _watchColumnProfileFilterFavorite((r) => r.profileFilterFavorites);

  Stream<T?> _watchColumnProfileFilterFavorite<T extends Object>(
    T? Function(ProfileFilterFavorite) extractColumn,
  ) {
    return (select(
      profileFilterFavorites,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchShowAdvancedFilters() {
    return (select(
      showAdvancedProfileFilters,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return r?.advancedFilters;
    });
  }

  Stream<GridSettings> watchGridSettings() {
    return (select(
      gridSettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return GridSettings(itemSizeMode: r?.gridItemSizeMode, paddingMode: r?.gridPaddingMode);
    });
  }

  Stream<ChatBackupReminder?> watchChatBackupReminder() {
    return (select(
      chatBackupReminder,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return ChatBackupReminder(
        reminderIntervalDays: r?.reminderIntervalDays,
        lastBackupTime: r?.lastBackupTime,
        lastDialogOpenedTime: r?.lastDialogOpenedTime,
      );
    });
  }
}
