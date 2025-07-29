
import 'package:async/async.dart' show StreamExtensions;
import 'package:openapi/api.dart' as api;
import 'package:database/src/model/profile.dart';
import 'package:database/src/converter/enum_string.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_available_profile_attributes.g.dart';

@DriftAccessor(tables: [Account])
class DaoAvailableProfileAttributes extends DatabaseAccessor<AccountDatabase> with _$DaoAvailableProfileAttributesMixin, AccountTools {
  DaoAvailableProfileAttributes(super.db);

  Future<void> updateClientConfig(
    api.AttributeOrderMode? orderMode,
    api.ClientConfigSyncVersion syncVersion,
    List<api.AttributeIdAndHash> latestAttributes,
    List<api.ProfileAttributeQueryItem> updatedAttributes,
    api.CustomReportsFileHash? customReportsFileHash,
    api.CustomReportsConfig? customReportsConfig,
    api.ClientFeaturesFileHash? clientFeaturesFileHash,
    api.ClientFeaturesConfig? clientFeaturesConfig,
  ) async {
    await transaction(() async {
      final currentAttributes = await db.daoAvailableProfileAttributesTable.watchAttributes().firstOrNull;
      if (currentAttributes == null) {
        return;
      }

      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          jsonAvailableProfileAttributesOrderMode: Value(orderMode?.toEnumString()),
        ),
      );

      await db.daoSyncVersions.updateSyncVersionClientConfig(syncVersion);

      for (final c in currentAttributes) {
        final l = latestAttributes.firstWhereOrNull((l) => l.id == c.attribute.id);
        if (l == null) {
          await db.daoAvailableProfileAttributesTable.deleteAttributeId(c.attribute.id);
        }
      }

      for (final u in updatedAttributes) {
        await db.daoAvailableProfileAttributesTable.updateAttribute(u.h, u.a);
      }

      await db.daoCustomReports.updateCustomReportsConfig(customReportsFileHash, customReportsConfig);
      await db.daoClientFeatures.updateClientFeaturesConfig(clientFeaturesFileHash, clientFeaturesConfig);
    });
  }

  Stream<ProfileAttributes?> watchAvailableProfileAttributes() =>
    Rx.combineLatest2(
      watchColumn((r) => r.jsonAvailableProfileAttributesOrderMode?.toAttributeOrderMode()),
      db.daoAvailableProfileAttributesTable.watchAttributes(),
      (orderMode, currentAttributes) {
        if (orderMode == null || currentAttributes == null) {
          return null;
        } else {
          return ProfileAttributes(orderMode, currentAttributes);
        }
      },
    );
}
