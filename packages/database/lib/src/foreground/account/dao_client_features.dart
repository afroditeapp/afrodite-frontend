
import 'package:openapi/api.dart' as api;
import 'package:database_converter/database_converter.dart';

import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_client_features.g.dart';

@DriftAccessor(tables: [Account])
class DaoClientFeatures extends DatabaseAccessor<AccountDatabase> with _$DaoClientFeaturesMixin, AccountTools {
  DaoClientFeatures(super.db);

  Future<void> updateClientFeaturesConfig(
    api.ClientFeaturesFileHash? fileHash,
    api.ClientFeaturesConfig? config,
  ) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        clientFeaturesFileHash: Value(fileHash),
        clientFeaturesConfig: Value(config?.toJsonString()),
      ),
    );
  }

  Stream<api.ClientFeaturesFileHash?> watchClientFeaturesFileHash() =>
    watchColumn((r) => r.clientFeaturesFileHash);
  Stream<api.ClientFeaturesConfig?> watchClientFeaturesConfig() =>
    watchColumn((r) => r.clientFeaturesConfig?.toClientFeaturesConfig());
}
