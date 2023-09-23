

import 'package:logging/logging.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

final log = Logger("ErrorManager");

class ErrorManager extends AppSingleton {
  static final _instance = ErrorManager();

  final PublishSubject<Error> _errors = PublishSubject();

  ErrorManager();

  factory ErrorManager.getInstance() {
    return _instance;
  }

  Stream<Error> listen() {
    return _errors.stream;
  }

  void send(Error e) {
    _errors.add(e);
    log.error(e.logMessage(), e);
    showSnackBar(e.title());
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}

sealed class Error {
  String title() { return ""; }
  String message() { return ""; }
  String logMessage() { return "${title()}, ${message()}"; }
}

// API errors

class ApiError extends Error {
  @override
  String title() { return "API error"; }
}

// File error

class FileError extends Error {
  @override
  String title() { return "File error"; }
}

// Database errors

sealed class DatabaseError extends Error {
  final DatabaseType database;
  final DatabaseException? exception;
  DatabaseError(this.database, this.exception);
  @override
  String title() {
    return database.databaseErrorTitle;
  }
  @override
  String logMessage() {
    return "${super.logMessage()}, ${exception?.toString()}";
  }
}
class DatabaseOpenError extends DatabaseError {
  DatabaseOpenError(DatabaseType database, DatabaseException exception) :
    super(database, exception);
}
class DatabaseCloseError extends DatabaseError {
  DatabaseCloseError(DatabaseType database, DatabaseException exception) :
    super(database, exception);
}
class DatabaseActionError extends DatabaseError {
  DatabaseActionError(DatabaseType database, DatabaseException exception) :
    super(database, exception);
}
