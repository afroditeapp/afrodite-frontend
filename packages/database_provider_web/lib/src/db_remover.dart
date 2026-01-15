import 'dart:async';
import 'dart:js_interop';

import 'package:drift/wasm.dart';
import 'package:database_utils/database_utils.dart';
import 'package:logging/logging.dart';
import 'package:web/web.dart';

final _log = Logger("DatabaseRemoverImpl");

class DatabaseRemoverImpl extends DatabaseRemover {
  @override
  Future<void> recreateDatabasesDir() async {
    throw UnsupportedError(
      'recreateDatabasesDir is not supported on web. Use deleteAllDatabases() instead.',
    );
  }

  @override
  Future<void> deleteAllDatabases() async {
    try {
      // Use Drift's WasmDatabase to find and delete all databases
      final probe = await WasmDatabase.probe(
        sqlite3Uri: Uri.parse("sqlite3.wasm"),
        driftWorkerUri: Uri.parse("drift_worker.js"),
      );

      // Delete all databases found by Drift
      for (final db in probe.existingDatabases) {
        try {
          await probe.deleteDatabase(db);
          _log.info("Deleted web database: $db");
        } catch (e, stackTrace) {
          _log.warning("Error deleting database $db", e, stackTrace);
        }
      }

      // Also clear IndexedDB completely (Drift might use IndexedDB for storage)
      await _clearAllIndexedDB();

      _log.info("All databases deleted successfully");
    } catch (e, stackTrace) {
      _log.severe("Error deleting all web databases", e, stackTrace);
    }
  }

  Future<void> _clearAllIndexedDB() async {
    try {
      // Get all database names from IndexedDB
      final databases = await window.indexedDB.databases().toDart;

      for (final dbInfo in databases.toDart) {
        final name = dbInfo.name;
        if (name.isNotEmpty) {
          try {
            final request = window.indexedDB.deleteDatabase(name);
            await _promisifyRequest(request);
            _log.info("Cleared IndexedDB database: $name");
          } catch (e) {
            _log.warning("Error clearing IndexedDB database $name: $e");
          }
        }
      }
    } catch (e, stackTrace) {
      _log.warning("Error clearing IndexedDB", e, stackTrace);
    }
  }

  Future<void> _promisifyRequest(IDBOpenDBRequest request) {
    final completer = Completer<void>();
    request.onsuccess = (Event e) {
      completer.complete();
    }.toJS;
    request.onerror = (Event e) {
      completer.completeError(Exception('IndexedDB operation failed'));
    }.toJS;
    return completer.future;
  }
}
