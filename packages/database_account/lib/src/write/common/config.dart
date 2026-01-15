import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'config.g.dart';

@DriftAccessor(
  tables: [
    schema.ClientFeaturesConfig,
    schema.CustomReportsConfig,
    schema.ProfileAttributesConfig,
    schema.ProfileAttributesConfigAttributes,
  ],
)
class DaoWriteConfig extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteConfigMixin {
  DaoWriteConfig(super.db);

  Future<void> updateClientFeaturesConfig(
    api.ClientFeaturesConfigHash? hash,
    api.ClientFeaturesConfig? config,
  ) async {
    await into(clientFeaturesConfig).insertOnConflictUpdate(
      ClientFeaturesConfigCompanion.insert(
        id: SingleRowTable.ID,
        clientFeaturesConfigHash: Value(hash),
        clientFeaturesConfig: Value(config?.toJsonObject()),
      ),
    );
  }

  Future<void> updateCustomReportsConfig(
    api.CustomReportsConfigHash? hash,
    api.CustomReportsConfig? config,
  ) async {
    await into(customReportsConfig).insertOnConflictUpdate(
      CustomReportsConfigCompanion.insert(
        id: SingleRowTable.ID,
        customReportsConfigHash: Value(hash),
        customReportsConfig: Value(config?.toJsonObject()),
      ),
    );
  }

  Future<void> deleteAttributeId(int id) async {
    await (delete(profileAttributesConfigAttributes)..where((t) => t.attributeId.equals(id))).go();
  }

  Future<void> updateAttribute(api.AttributeHash hash, api.Attribute attribute) async {
    await into(profileAttributesConfigAttributes).insertOnConflictUpdate(
      ProfileAttributesConfigAttributesCompanion.insert(
        attributeId: Value(attribute.id),
        attributeHash: hash,
        jsonAttribute: attribute.toJsonObject(),
      ),
    );
  }

  Future<void> updateClientConfig(
    api.AttributeOrderMode? orderMode,
    api.ClientConfigSyncVersion syncVersion,
    List<api.ProfileAttributeInfo> latestAttributes,
    List<api.ProfileAttributesConfigQueryItem> updatedAttributes,
    api.CustomReportsConfigHash? customReportsConfigHash,
    api.CustomReportsConfig? customReportsConfig,
    api.ClientFeaturesConfigHash? clientFeaturesConfigHash,
    api.ClientFeaturesConfig? clientFeaturesConfig,
  ) async {
    await transaction(() async {
      final currentAttributes = await db.read.config.watchAttributes().firstOrNull;
      if (currentAttributes == null) {
        return;
      }

      await into(profileAttributesConfig).insertOnConflictUpdate(
        ProfileAttributesConfigCompanion.insert(
          id: SingleRowTable.ID,
          jsonAvailableProfileAttributesOrderMode: Value(orderMode?.toEnumString()),
        ),
      );

      await db.write.common.updateSyncVersionClientConfig(syncVersion);

      for (final c in currentAttributes) {
        final l = latestAttributes.firstWhereOrNull((l) => l.id == c.attribute.id);
        if (l == null) {
          await db.write.config.deleteAttributeId(c.attribute.id);
        }
      }

      for (final u in updatedAttributes) {
        await db.write.config.updateAttribute(u.h, u.a);
      }

      await db.write.config.updateCustomReportsConfig(customReportsConfigHash, customReportsConfig);
      await db.write.config.updateClientFeaturesConfig(
        clientFeaturesConfigHash,
        clientFeaturesConfig,
      );
    });
  }
}
