import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:database_model/database_model.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileFilterFavorites,
    schema.ShowAdvancedProfileFilters,
    schema.InitialSync,
    schema.InitialSetupSkipped,
    schema.GridSettings,
  ],
)
class DaoWriteApp extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> updateLoginSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneLoginRepository: Value(value),
      ),
    );
  }

  Future<void> updateAccountSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneAccountRepository: Value(value),
      ),
    );
  }

  Future<void> updateMediaSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneMediaRepository: Value(value),
      ),
    );
  }

  Future<void> updateProfileSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneProfileRepository: Value(value),
      ),
    );
  }

  Future<void> updateChatSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneChatRepository: Value(value),
      ),
    );
  }

  Future<void> updateInitialSetupSkipped(bool skipped) async {
    await into(initialSetupSkipped).insertOnConflictUpdate(
      InitialSetupSkippedCompanion.insert(
        id: SingleRowTable.ID,
        initialSetupSkipped: Value(skipped),
      ),
    );
  }

  Future<void> updateProfileFilterFavorites(bool value) async {
    await into(profileFilterFavorites).insertOnConflictUpdate(
      ProfileFilterFavoritesCompanion.insert(
        id: SingleRowTable.ID,
        profileFilterFavorites: Value(value),
      ),
    );
  }

  Future<void> updateShowAdvancedFilters(bool value) async {
    await into(showAdvancedProfileFilters).insertOnConflictUpdate(
      ShowAdvancedProfileFiltersCompanion.insert(
        id: SingleRowTable.ID,
        advancedFilters: Value(value),
      ),
    );
  }

  Future<void> updateGridSettings(GridSettings value) async {
    await into(gridSettings).insertOnConflictUpdate(
      GridSettingsCompanion.insert(
        id: SingleRowTable.ID,
        gridHorizontalPadding: Value(value.horizontalPadding),
        gridInternalPadding: Value(value.internalPadding),
        gridProfileThumbnailBorderRadius: Value(value.profileThumbnailBorderRadius),
        gridRowProfileCount: Value(value.rowProfileCount),
      ),
    );
  }
}
