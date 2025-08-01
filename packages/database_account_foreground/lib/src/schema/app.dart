import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class ProfileFilterFavorites extends SingleRowTable {
  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean()
    .withDefault(const Constant(false))();
}

class ShowAdvancedProfileFilters extends SingleRowTable {
  BoolColumn get advancedFilters => boolean().withDefault(const Constant(false))();
}

class InitialSync extends SingleRowTable {
  BoolColumn get initialSyncDoneLoginRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneAccountRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneMediaRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneProfileRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneChatRepository => boolean()
    .withDefault(const Constant(false))();
}

class InitialSetupSkipped extends SingleRowTable {
  BoolColumn get initialSetupSkipped => boolean()
    .withDefault(const Constant(false))();
}

class ImageSettings extends SingleRowTable {
  IntColumn get imageCacheMaxBytes => integer().nullable()();
  BoolColumn get cacheFullSizedImages => boolean().nullable()();
  IntColumn get imageCacheDownscalingSize => integer().nullable()();
}

class GridSettings extends SingleRowTable {
  RealColumn get gridHorizontalPadding => real().nullable()();
  RealColumn get gridInternalPadding => real().nullable()();
  RealColumn get gridProfileThumbnailBorderRadius => real().nullable()();
  IntColumn get gridRowProfileCount => integer().nullable()();
}
