


import 'package:async/async.dart' show StreamExtensions;
import 'package:database/database.dart';
import 'package:database/src/converter/json/string.dart';
import 'package:database/src/converter/profile.dart';
import 'package:openapi/api.dart' show Attribute, ProfileAttributeHash, AttributeIdAndHash;
import 'package:collection/collection.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';

part 'available_profile_attributes_table.g.dart';

class AvailableProfileAttributesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get jsonAttribute => text().map(JsonString.driftConverter)();
  TextColumn get attributeHash => text().map(const ProfileAttributeHashConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftAccessor(tables: [AvailableProfileAttributesTable])
class DaoAvailableProfileAttributesTable extends DatabaseAccessor<AccountDatabase> with _$DaoAvailableProfileAttributesTableMixin {
  DaoAvailableProfileAttributesTable(super.db);

  Future<void> deleteAttributeId(int id) async {
    await (delete(availableProfileAttributesTable)..where((t) => t.id.equals(id)))
      .go();
  }

  Future<void> updateAttribute(
    ProfileAttributeHash hash,
    Attribute attribute,
  ) async {
    await into(availableProfileAttributesTable).insert(
      AvailableProfileAttributesTableCompanion.insert(
        id: Value(attribute.id),
        attributeHash: hash,
        jsonAttribute: attribute.toJsonString(),
      ),
      onConflict: DoUpdate((old) => AvailableProfileAttributesTableCompanion(
        attributeHash: Value(hash),
        jsonAttribute: Value(attribute.toJsonString()),
      ),
        target: [availableProfileAttributesTable.id]
      ),
    );
  }

  /// Get list of attribute IDs which require refresh.
  Future<List<int>> getAttributeRefreshList(
    List<AttributeIdAndHash> availableAttributes,
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
    return (select(availableProfileAttributesTable)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc),
      ])
    )
      .watch()
      .map((r) {
        final List<ProfileAttributeAndHash> attributes = [];
        for (final item in r) {
          final attribute = item.jsonAttribute.toAttribute();
          if (attribute == null) {
            return null;
          }
          attributes.add(ProfileAttributeAndHash(item.attributeHash, attribute));
        }

        return attributes;
      });
  }
}
