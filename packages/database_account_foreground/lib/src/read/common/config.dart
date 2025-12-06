import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:rxdart/rxdart.dart';

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
class DaoReadConfig extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadConfigMixin {
  DaoReadConfig(super.db);

  Stream<api.ClientFeaturesConfigHash?> watchClientFeaturesConfigHash() =>
      _watchColumnClientFeatures((r) => r.clientFeaturesConfigHash);
  Stream<api.ClientFeaturesConfig?> watchClientFeaturesConfig() =>
      _watchColumnClientFeatures((r) => r.clientFeaturesConfig?.value);

  Stream<T?> _watchColumnClientFeatures<T extends Object>(
    T? Function(ClientFeaturesConfigData) extractColumn,
  ) {
    return (select(
      clientFeaturesConfig,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<api.CustomReportsConfigHash?> watchCustomReportsConfigHash() =>
      _watchColumnCustomReports((r) => r.customReportsConfigHash);
  Stream<api.CustomReportsConfig?> watchCustomReportsConfig() =>
      _watchColumnCustomReports((r) => r.customReportsConfig?.value);

  Stream<T?> _watchColumnCustomReports<T extends Object>(
    T? Function(CustomReportsConfigData) extractColumn,
  ) {
    return (select(
      customReportsConfig,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  /// Get list of attribute IDs which require refresh.
  Future<List<int>> getAttributeRefreshList(
    List<api.ProfileAttributeInfo> availableAttributes,
  ) async {
    final currentAttributes = await watchAttributes().firstOrNull;
    if (currentAttributes == null) {
      return availableAttributes.map((v) => v.id).toList();
    }
    final List<int> refreshList = [];
    for (final serverAttribute in availableAttributes) {
      final localAttribute = currentAttributes.firstWhereOrNull((v) {
        return v.attribute.id == serverAttribute.id;
      });
      if (localAttribute == null || localAttribute.hash != serverAttribute.h) {
        refreshList.add(serverAttribute.id);
      }
    }
    return refreshList;
  }

  /// Attributes are sorted by attribute ID
  Stream<List<ProfileAttributeAndHash>?> watchAttributes() {
    return (select(profileAttributesConfigAttributes)
          ..orderBy([(t) => OrderingTerm(expression: t.attributeId, mode: OrderingMode.asc)]))
        .watch()
        .map((r) {
          final List<ProfileAttributeAndHash> attributes = [];
          for (final item in r) {
            final attribute = item.jsonAttribute.value;
            if (attribute == null) {
              return null;
            }
            attributes.add(ProfileAttributeAndHash(item.attributeHash, attribute));
          }

          return attributes;
        });
  }

  Stream<ProfileAttributes?> watchAvailableProfileAttributes() => Rx.combineLatest2(
    _watchColumnProfileAttributesConfig((r) => r.jsonAvailableProfileAttributesOrderMode?.value),
    watchAttributes(),
    (orderMode, currentAttributes) {
      if (orderMode == null || currentAttributes == null) {
        return null;
      } else {
        return ProfileAttributes(orderMode, currentAttributes);
      }
    },
  );

  Stream<T?> _watchColumnProfileAttributesConfig<T extends Object>(
    T? Function(ProfileAttributesConfigData) extractColumn,
  ) {
    return (select(
      profileAttributesConfig,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
