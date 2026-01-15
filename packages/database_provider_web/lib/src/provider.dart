import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:logging/logging.dart';
import 'package:utils/utils.dart';

final _log = Logger("DbProviderWeb");

class DbProvider implements QueryExcecutorProvider {
  final DbFile db;
  DbProvider(this.db, {required bool backgroundDb});

  DatabaseConnection? connection;

  @override
  QueryExecutor getQueryExcecutor() {
    connection ??= DatabaseConnection.delayed(
      Future(() async {
        final result = await WasmDatabase.open(
          databaseName: dbFileToDbName(db),
          sqlite3Uri: Uri.parse("sqlite3.wasm"),
          driftWorkerUri: Uri.parse("drift_worker.js"),
        );

        _log.info("Drift database implementation: ${result.chosenImplementation.name}");
        if (result.missingFeatures.isNotEmpty) {
          _log.error("Drift database missing features: ${result.missingFeatures}");
        }

        return result.resolvedExecutor;
      }),
    );

    return connection!;
  }
}

String dbFileToDbName(DbFile dbFile) {
  switch (dbFile) {
    case CommonDbFile():
      return "common.db";
    case AccountDbFile():
      return "account_${dbFile.accountId}.db";
    case AccountBackgroundDbFile():
      return "account_background_${dbFile.accountId}.db";
  }
}

Future<bool> databaseExists(DbFile db) async {
  try {
    final dbName = dbFileToDbName(db);
    final probe = await WasmDatabase.probe(
      databaseName: dbName,
      sqlite3Uri: Uri.parse("sqlite3.wasm"),
      driftWorkerUri: Uri.parse("drift_worker.js"),
    );
    return probe.existingDatabases.any((db) => db.$2 == dbName);
  } catch (e) {
    _log.warning("Error checking database existence: $e");
    return false;
  }
}
