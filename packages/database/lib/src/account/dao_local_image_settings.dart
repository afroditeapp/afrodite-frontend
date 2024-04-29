
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_local_image_settings.g.dart';

@DriftAccessor(tables: [Account])
class DaoLocalImageSettings extends DatabaseAccessor<AccountDatabase> with _$DaoLocalImageSettingsMixin, AccountTools {
  DaoLocalImageSettings(super.db);

  Future<void> updateImageCacheMaxBytes(int value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localImageSettingImageCacheMaxBytes: Value(value),
      ),
    );
  }

  Future<void> updateCacheFullSizedImages(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localImageSettingCacheFullSizedImages: Value(value),
      ),
    );
  }

  Future<void> updateImageCacheDownscalingSize(int value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localImageSettingImageCacheDownscalingSize: Value(value),
      ),
    );
  }

  Stream<int?> watchLocalImageSettingImageCacheMaxBytes() =>
    watchColumn((r) => r.localImageSettingImageCacheMaxBytes);
  Stream<bool?> watchCacheFullSizedImages() =>
    watchColumn((r) => r.localImageSettingCacheFullSizedImages);
  Stream<int?> watchImageCacheDownscalingSize() =>
    watchColumn((r) => r.localImageSettingImageCacheDownscalingSize);
}
